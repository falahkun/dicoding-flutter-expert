import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

import '../dummy/movie_object.dart';
import '../dummy/tv_objects.dart';
import 'movie_bloc_mocks.dart';
import 'tv_bloc_mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MovieDetailBloc? mockMovieDetailBloc,
    NowPlayingBloc? mockNowPlayingBloc,
    PopularBloc? mockPopularBloc,
    MovieRecommendationBloc? mockMovieRecommendationBloc,
    TopRatedBloc? mockTopRatedBloc,
    MovieWatchlistBloc? mockMovieWatchlistBloc,
    WatchlistMovieBloc? mockWatchlistMovieBloc,
    TvDetailBloc? mockTvDetailBloc,
    TvNowPlayingBloc? mockTvNowPlayingBloc,
    TvPopularBloc? mockTvPopularBloc,
    TvRecommendationBloc? mockTvRecommendationBloc,
    TvTopRatedBloc? mockTvTopRatedBloc,
    TvWatchlistBloc? mockTvWatchlistBloc,
    WatchlistTvBloc? mockWatchlistTvBloc,
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

    if (mockMovieDetailBloc == null) {
      when(() => _mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(testMovieDetail));
    }
    if (mockNowPlayingBloc == null) {
      when(() => _mockNowPlayingBloc.state)
          .thenReturn(NowPlayingLoaded(testMovieList));
    }

    if (mockTopRatedBloc == null) {
      when(() => _mockTopRatedBloc.state)
          .thenReturn(TopRatedLoaded(testMovieList));
    }
    if (mockPopularBloc == null) {
      when(() => _mockPopularBloc.state)
          .thenReturn(PopularLoaded(testMovieList));
    }
    if (mockMovieRecommendationBloc == null) {
      when(() => _mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(testMovieList));
    }

    // tv

    final _mockTvDetailBloc = mockTvDetailBloc ?? MockTvDetailBloc();
    final _mockTvNowPlayingBloc =
        mockTvNowPlayingBloc ?? MockTvNowPlayingBloc();
    final _mockTvPopularBloc = mockTvPopularBloc ?? MockTvPopularBloc();
    final _mockTvRecommendationBloc =
        mockTvRecommendationBloc ?? MockTvRecommendationBloc();
    final _mockTvTopRatedBloc = mockTvTopRatedBloc ?? MockTvTopRatedBloc();
    final _mockTvWatchlistBloc = mockTvWatchlistBloc ?? MockTvWatchlistBloc();
    final _mockWatchlistTvBloc = mockWatchlistTvBloc ?? MockWatchlistTvBloc();

    if (mockTvWatchlistBloc == null) {
      when(() => _mockTvWatchlistBloc.state)
          .thenReturn(TvWatchlistState(false));
    }

    if (mockWatchlistTvBloc == null) {
      when(() => _mockWatchlistTvBloc.state).thenReturn(WatchlistTvInitial());
    }

    if (mockTvDetailBloc == null) {
      when(() => _mockTvDetailBloc.state)
          .thenReturn(TvDetailLoaded(testTvDetail));
    }

    if (mockTvNowPlayingBloc == null) {
      when(() => _mockTvNowPlayingBloc.state)
          .thenReturn(TvNowPlayingLoaded(testTvList));
    }

    if (mockTvTopRatedBloc == null) {
      when(() => _mockTvTopRatedBloc.state)
          .thenReturn(TvTopRatedLoaded(testTvList));
    }
    if (mockTvPopularBloc == null) {
      when(() => _mockTvPopularBloc.state)
          .thenReturn(TvPopularLoaded(testTvList));
    }
    if (mockTvRecommendationBloc == null) {
      when(() => _mockTvRecommendationBloc.state)
          .thenReturn(TvRecommendationLoaded(testTvList));
    }

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
          BlocProvider<TvDetailBloc>(
            lazy: false,
            create: (_) => _mockTvDetailBloc,
          ),
          BlocProvider<TvNowPlayingBloc>(
            lazy: false,
            create: (_) => _mockTvNowPlayingBloc,
          ),
          BlocProvider<TvPopularBloc>(
            lazy: false,
            create: (_) => _mockTvPopularBloc,
          ),
          BlocProvider<TvRecommendationBloc>(
            lazy: false,
            create: (_) => _mockTvRecommendationBloc,
          ),
          BlocProvider<TvTopRatedBloc>(
            lazy: false,
            create: (_) => _mockTvTopRatedBloc,
          ),
          BlocProvider<TvWatchlistBloc>(
            lazy: false,
            create: (_) => _mockTvWatchlistBloc,
          ),
          BlocProvider<WatchlistTvBloc>(
            lazy: false,
            create: (_) => _mockWatchlistTvBloc,
          ),
        ],
        child: MaterialApp(
          navigatorObservers: [
            MockNavigatorObserver(),
          ],
          home: MediaQuery(
            data: const MediaQueryData(),
            child: widget,
          ),
        ),
      ),
    );
  }
}
