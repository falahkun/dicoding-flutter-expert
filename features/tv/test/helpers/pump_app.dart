import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../dummy/tv_objects.dart';
import 'tv_bloc_mocks.dart';


extension PumpApp on WidgetTester {
  Future<void> pumpApp(
      Widget widget, {
        TvDetailBloc? mockTvDetailBloc,
        TvNowPlayingBloc? mockNowPlayingBloc,
        TvPopularBloc? mockPopularBloc,
        TvRecommendationBloc? mockTvRecommendationBloc,
        TvTopRatedBloc? mockTopRatedBloc,
        TvWatchlistBloc? mockTvWatchlistBloc,
        WatchlistTvBloc? mockWatchlistTvBloc,
      }) {
    final _mockTvDetailBloc = mockTvDetailBloc ?? MockTvDetailBloc();
    final _mockNowPlayingBloc = mockNowPlayingBloc ?? MockTvNowPlayingBloc();
    final _mockPopularBloc = mockPopularBloc ?? MockTvPopularBloc();
    final _mockTvRecommendationBloc =
        mockTvRecommendationBloc ?? MockTvRecommendationBloc();
    final _mockTopRatedBloc = mockTopRatedBloc ?? MockTvTopRatedBloc();
    final _mockTvWatchlistBloc =
        mockTvWatchlistBloc ?? MockTvWatchlistBloc();
    final _mockWatchlistTvBloc =
        mockWatchlistTvBloc ?? MockWatchlistTvBloc();

    if (mockTvWatchlistBloc == null) {
      when(() => _mockTvWatchlistBloc.state)
          .thenReturn(TvWatchlistState(false));
    }

    if (mockWatchlistTvBloc == null) {
      when(() => _mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvInitial());
    }

    if (mockTvDetailBloc == null)
      when(() => _mockTvDetailBloc.state)
          .thenReturn(TvDetailLoaded(testTvDetail));

    if (mockNowPlayingBloc == null)
      when(() => _mockNowPlayingBloc.state)
          .thenReturn(TvNowPlayingLoaded(testTvList));

    if (mockTopRatedBloc == null)
      when(() => _mockTopRatedBloc.state)
          .thenReturn(TvTopRatedLoaded(testTvList));
    if (mockPopularBloc == null)
      when(() => _mockPopularBloc.state)
          .thenReturn(TvPopularLoaded(testTvList));
    if (mockTvRecommendationBloc == null)
      when(() => _mockTvRecommendationBloc.state)
          .thenReturn(TvRecommendationLoaded(testTvList));

    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<TvDetailBloc>(
            lazy: false,
            create: (_) => _mockTvDetailBloc,
          ),
          BlocProvider<TvNowPlayingBloc>(
            lazy: false,
            create: (_) => _mockNowPlayingBloc,
          ),
          BlocProvider<TvPopularBloc>(
            lazy: false,
            create: (_) => _mockPopularBloc,
          ),
          BlocProvider<TvRecommendationBloc>(
            lazy: false,
            create: (_) => _mockTvRecommendationBloc,
          ),
          BlocProvider<TvTopRatedBloc>(
            lazy: false,
            create: (_) => _mockTopRatedBloc,
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
          home: MediaQuery(
            data: const MediaQueryData(),
            child: widget,
          ),
        ),
      ),
    );
  }
}
