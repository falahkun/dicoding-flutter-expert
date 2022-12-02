import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/src/presentation/blocs/blocs.dart';
import 'package:tv/tv.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/tv_bloc_mocks.dart';

void main() {
  late TvTopRatedBloc bloc;

  setUp(() {
    bloc = MockTvTopRatedBloc();
  });

  group('src/presentation/pages/top_rated_tv_page.dart', () {
    testWidgets('test render', (tester) async {
      await tester.pumpApp(TopRatedTvPage());
      expect(find.text('Top Rated Tv'), findsOneWidget);
    });

    testWidgets('when state error', (widgetTester) async {
      when(() => bloc.state).thenReturn(TvTopRatedError('failed'));

      await widgetTester.pumpApp(
        TopRatedTvPage(),
        mockTopRatedBloc: bloc,
      );

      expect(
        find.byKey(Key('error_message')),
        findsOneWidget,
      );
    });

    testWidgets('when state loading', (widgetTester) async {
      when(() => bloc.state).thenReturn(TvTopRatedLoading());

      await widgetTester.pumpApp(
        TopRatedTvPage(),
        mockTopRatedBloc: bloc,
      );

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
    });

    testWidgets('when state laoded', (widgetTester) async {
      when(() => bloc.state).thenReturn(TvTopRatedLoaded(testTvList));

      await widgetTester.pumpApp(
        TopRatedTvPage(),
        mockTopRatedBloc: bloc,
      );

      expect(
        find.byType(TvCard),
        findsOneWidget,
      );
    });
  });
}
