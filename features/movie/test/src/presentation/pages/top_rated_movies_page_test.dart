import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';
import '../../../helpers/movie_bloc_mocks.dart';
import '../../../helpers/pump_app.dart';

void main() {
  group('package:movie/src/presentation/pages/top_rated_movies_page.dart', () {
    testWidgets('test render', (widgetTester) async {
      await widgetTester.pumpApp(TopRatedMoviesPage());
      expect(find.text('Top Rated Movies'), findsOneWidget);
    });

    testWidgets('test state error', (widgetTester) async {
      final mockTopRatedMovieBloc = MockTopRatedBloc();
      when(() => mockTopRatedMovieBloc.state).thenReturn(TopRatedError('failed'));

      await widgetTester.pumpApp(
        TopRatedMoviesPage(),
        mockTopRatedBloc: mockTopRatedMovieBloc,
      );
      expect(find.byKey(Key('error_message')), findsOneWidget);
    });
    testWidgets('test state loading', (widgetTester) async {
      final mockTopRatedMovieBloc = MockTopRatedBloc();
      when(() => mockTopRatedMovieBloc.state).thenReturn(TopRatedLoading());

      await widgetTester.pumpApp(
        TopRatedMoviesPage(),
        mockTopRatedBloc: mockTopRatedMovieBloc,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('test state loaded', (widgetTester) async {
      final mockTopRatedMovieBloc = MockTopRatedBloc();
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedLoaded(testMovieList));

      await widgetTester.pumpApp(
        TopRatedMoviesPage(),
        mockTopRatedBloc: mockTopRatedMovieBloc,
      );
      expect(find.byType(MovieCard), findsOneWidget);
    });
  });
}
