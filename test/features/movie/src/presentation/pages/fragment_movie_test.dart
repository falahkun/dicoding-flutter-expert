import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../../../dummy/movie_object.dart';
import '../../../../../helpers/pump_app.dart';

void main() {
  group('package:movie/src/presentation/pages/fragment_movie.dart', () {
    testWidgets('test render', (tester) async {
      await tester.pumpApp(FragmentMovie());
      expect(find.text('Now Playing'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
    });

    testWidgets('test if all state error', (widgetTester) async {
      final mockNowPlayingMovieBloc = MockNowPlayingBloc();
      final mockPopularMovieBloc = MockPopularBloc();
      final mockTopRatedMovieBloc = MockTopRatedBloc();

      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowPlayingError('failed'));
      when(() => mockPopularMovieBloc.state).thenReturn(PopularError('failed'));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedError('failed'));

      await widgetTester.pumpApp(
        FragmentMovie(),
        mockNowPlayingBloc: mockNowPlayingMovieBloc,
        mockPopularBloc: mockPopularMovieBloc,
        mockTopRatedBloc: mockTopRatedMovieBloc,
      );

      expect(find.text('Failed'), findsNWidgets(3));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
    testWidgets('test if all state loading', (widgetTester) async {
      final mockNowPlayingMovieBloc = MockNowPlayingBloc();
      final mockPopularMovieBloc = MockPopularBloc();
      final mockTopRatedMovieBloc = MockTopRatedBloc();

      when(() => mockNowPlayingMovieBloc.state).thenReturn(NowPlayingLoading());
      when(() => mockPopularMovieBloc.state).thenReturn(PopularLoading());
      when(() => mockTopRatedMovieBloc.state).thenReturn(TopRatedLoading());

      await widgetTester.pumpApp(
        FragmentMovie(),
        mockNowPlayingBloc: mockNowPlayingMovieBloc,
        mockPopularBloc: mockPopularMovieBloc,
        mockTopRatedBloc: mockTopRatedMovieBloc,
      );

      expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
    });
    testWidgets('test if all state loaded', (widgetTester) async {
      final mockNowPlayingMovieBloc = MockNowPlayingBloc();
      final mockPopularMovieBloc = MockPopularBloc();
      final mockTopRatedMovieBloc = MockTopRatedBloc();

      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowPlayingLoaded(testMovieList));
      when(() => mockPopularMovieBloc.state)
          .thenReturn(PopularLoaded(testMovieList));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedLoaded(testMovieList));

      await widgetTester.pumpApp(
        FragmentMovie(),
        mockNowPlayingBloc: mockNowPlayingMovieBloc,
        mockPopularBloc: mockPopularMovieBloc,
        mockTopRatedBloc: mockTopRatedMovieBloc,
      );

      expect(find.byType(MovieList), findsNWidgets(3));
    });
  });
}
