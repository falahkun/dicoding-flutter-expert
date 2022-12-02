import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/src/presentation/blocs/blocs.dart';
import 'package:tv/tv.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/tv_bloc_mocks.dart';

void main() {
  late TvPopularBloc bloc;

  setUp(() {
    bloc = MockTvPopularBloc();
  });

  group('src/presentation/pages/top_rated_tv_page.dart', () {
    testWidgets('test render', (tester) async {
      await tester.pumpApp(PopularTvPage());
      expect(find.text('Popular Tv'), findsOneWidget);
    });

    testWidgets('when state error', (widgetTester) async {
      when(() => bloc.state).thenReturn(TvPopularError('failed'));

      await widgetTester.pumpApp(
        PopularTvPage(),
        mockPopularBloc: bloc,
      );

      expect(
        find.byKey(Key('error_message')),
        findsOneWidget,
      );
    });

    testWidgets('when state loading', (widgetTester) async {
      when(() => bloc.state).thenReturn(TvPopularLoading());

      await widgetTester.pumpApp(
        PopularTvPage(),
        mockPopularBloc: bloc,
      );

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
    });

    testWidgets('when state laoded', (widgetTester) async {
      when(() => bloc.state).thenReturn(TvPopularLoaded(testTvList));

      await widgetTester.pumpApp(
        PopularTvPage(),
        mockPopularBloc: bloc,
      );

      expect(
        find.byType(TvCard),
        findsOneWidget,
      );
    });
  });
}
