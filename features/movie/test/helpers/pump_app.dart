import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../dummy/movie_object.dart';
import 'movie_bloc_mocks.dart';


extension PumpApp on WidgetTester {
  Future<void> pumpApp(
      Widget widget, {
        MockMovieDetailBloc? mockMovieDetailBloc,
        MockNowPlayingBloc? mockNowPlayingBloc,
        MockPopularBloc? mockPopularBloc,
        MockMovieRecommendationBloc? mockMovieRecommendationBloc,
        MockTopRatedBloc? mockTopRatedBloc,
        MockMovieWatchlistBloc? mockMovieWatchlistBloc,
        MockWatchlistMovieBloc? mockWatchlistMovieBloc,
      }) {
    final _mockMovieDetailBloc = mockMovieDetailBloc ?? MockMovieDetailBloc();
    final _mockNowPlayingBloc = mockNowPlayingBloc ?? MockNowPlayingBloc();
    final _mockPopularBloc = mockPopularBloc ?? MockPopularBloc();
    final _mockMovieRecommendationBloc =
        mockMovieRecommendationBloc ?? MockMovieRecommendationBloc();
    final _mockTopRatedBloc = mockTopRatedBloc ?? MockTopRatedBloc();
    final _mockMovieWatchlistBloc =
        mockMovieWatchlistBloc ?? MockMovieWatchlistBloc();
    final _mockWatchlistMovieBloc =
        mockWatchlistMovieBloc ?? MockWatchlistMovieBloc();

    if (mockMovieWatchlistBloc == null) {
      when(() => _mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistState(false));
    }

    if (mockWatchlistMovieBloc == null) {
      when(() => _mockWatchlistMovieBloc.state)
          .thenReturn(WatchlistMovieInitial());
    }

    if (mockMovieDetailBloc == null)
      when(() => _mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(testMovieDetail));
    if (mockNowPlayingBloc == null)
      when(() => _mockNowPlayingBloc.state)
          .thenReturn(NowPlayingLoaded(testMovieList));

    if (mockTopRatedBloc == null)
      when(() => _mockTopRatedBloc.state)
          .thenReturn(TopRatedLoaded(testMovieList));
    if (mockPopularBloc == null)
      when(() => _mockPopularBloc.state)
          .thenReturn(PopularLoaded(testMovieList));
    if (mockMovieRecommendationBloc == null)
      when(() => _mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(testMovieList));

    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(
            lazy: false,
            create: (_) => _mockMovieDetailBloc,
          ),
          BlocProvider<NowPlayingBloc>(
            lazy: false,
            create: (_) => _mockNowPlayingBloc,
          ),
          BlocProvider<PopularBloc>(
            lazy: false,
            create: (_) => _mockPopularBloc,
          ),
          BlocProvider<MovieRecommendationBloc>(
            lazy: false,
            create: (_) => _mockMovieRecommendationBloc,
          ),
          BlocProvider<TopRatedBloc>(
            lazy: false,
            create: (_) => _mockTopRatedBloc,
          ),
          BlocProvider<MovieWatchlistBloc>(
            lazy: false,
            create: (_) => _mockMovieWatchlistBloc,
          ),
          BlocProvider<WatchlistMovieBloc>(
            lazy: false,
            create: (_) => _mockWatchlistMovieBloc,
          ),
        ],
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(),
            child: widget,
          ),
        ),
      ),
    );
  }
}
