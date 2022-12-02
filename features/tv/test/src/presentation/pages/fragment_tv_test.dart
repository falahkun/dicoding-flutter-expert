import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/tv_bloc_mocks.dart';

void main() {
  late TvNowPlayingBloc tvNowPlayingBloc;
  late TvPopularBloc tvPopularBloc;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    tvPopularBloc = MockTvPopularBloc();
    tvTopRatedBloc = MockTvTopRatedBloc();
    tvNowPlayingBloc = MockTvNowPlayingBloc();
  });

  group('package:tv/src/presentation/pages/fragment_tv.dart', () {
    testWidgets('test render', (widgetTester) async {
      await widgetTester.pumpApp(FragmentTv());
      expect(find.text('On The Air'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
    });

    testWidgets('state all error', (widgetTester) async {
      when(() => tvNowPlayingBloc.state)
          .thenReturn(TvNowPlayingError('failed'));
      when(() => tvPopularBloc.state).thenReturn(TvPopularError('failed'));
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedError('failed'));

      await widgetTester.pumpApp(
        FragmentTv(),
        mockNowPlayingBloc: tvNowPlayingBloc,
        mockPopularBloc: tvPopularBloc,
        mockTopRatedBloc: tvTopRatedBloc,
      );
      expect(find.text('Failed'), findsNWidgets(3));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('state all loading', (widgetTester) async {
      when(() => tvNowPlayingBloc.state).thenReturn(TvNowPlayingLoading());
      when(() => tvPopularBloc.state).thenReturn(TvPopularLoading());
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedLoading());

      await widgetTester.pumpApp(
        FragmentTv(),
        mockNowPlayingBloc: tvNowPlayingBloc,
        mockPopularBloc: tvPopularBloc,
        mockTopRatedBloc: tvTopRatedBloc,
      );

      expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
    });

    testWidgets('state all loaded', (widgetTester) async {
      when(() => tvNowPlayingBloc.state).thenReturn(TvNowPlayingLoaded(testTvList));
      when(() => tvPopularBloc.state).thenReturn(TvPopularLoaded(testTvList));
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedLoaded(testTvList));

      await widgetTester.pumpApp(
        FragmentTv(),
        mockNowPlayingBloc: tvNowPlayingBloc,
        mockPopularBloc: tvPopularBloc,
        mockTopRatedBloc: tvTopRatedBloc,
      );

      expect(find.byType(TvList), findsNWidgets(3));
    });
  });
}
