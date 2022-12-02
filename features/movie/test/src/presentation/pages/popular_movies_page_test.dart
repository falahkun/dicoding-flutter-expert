import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';
import '../../../helpers/movie_bloc_mocks.dart';
import '../../../helpers/pump_app.dart';

void main() {
  group('package:movie/src/presentation/pages/popular_movies_page.dart', () {
    testWidgets('test render', (widgetTester) async {
      await widgetTester.pumpApp(PopularMoviesPage());
      expect(find.text('Popular Movies'), findsOneWidget);
    });

    testWidgets('test state error', (widgetTester) async {
      final mockPopularMovieBloc = MockPopularBloc();
      when(() => mockPopularMovieBloc.state).thenReturn(PopularError('failed'));

      await widgetTester.pumpApp(
        PopularMoviesPage(),
        mockPopularBloc: mockPopularMovieBloc,
      );
      expect(find.byKey(Key('error_message')), findsOneWidget);
    });
    testWidgets('test state loading', (widgetTester) async {
      final mockPopularMovieBloc = MockPopularBloc();
      when(() => mockPopularMovieBloc.state).thenReturn(PopularLoading());

      await widgetTester.pumpApp(
        PopularMoviesPage(),
        mockPopularBloc: mockPopularMovieBloc,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('test state loaded', (widgetTester) async {
      final mockPopularMovieBloc = MockPopularBloc();
      when(() => mockPopularMovieBloc.state)
          .thenReturn(PopularLoaded(testMovieList));

      await widgetTester.pumpApp(
        PopularMoviesPage(),
        mockPopularBloc: mockPopularMovieBloc,
      );
      expect(find.byType(MovieCard), findsOneWidget);
    });
  });
}
