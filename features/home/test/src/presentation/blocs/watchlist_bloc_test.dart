import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/movie_object.dart';
import '../../../dummy/tv_objects.dart';

class MockTvUseCase extends Mock implements TvUseCase {}

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late TvUseCase tvUseCase;
  late GetWatchlistMovies watchlistMovies;

  late WatchlistBloc watchlistBloc;

  setUp(() {
    tvUseCase = MockTvUseCase();
    watchlistMovies = MockGetWatchlistMovies();
    watchlistBloc = WatchlistBloc(
      tvUseCase: tvUseCase,
      getWatchlistMovies: watchlistMovies,
    );
  });

  void _mockWatchlistSuccess() {
    when(() => tvUseCase.getWatchlistTv()).thenAnswer(
          (_) async => Right<Failure, List<Tv>>(testTvList),
    );
    when(() => watchlistMovies.execute())
        .thenAnswer((_) async => Right<Failure, List<Movie>>(testMovieList));
  }

  void _mockWatchlistFailed() {
    when(() => tvUseCase.getWatchlistTv()).thenAnswer(
          (_) async => Left<Failure, List<Tv>>(ServerFailure('failed')),
    );
    when(() => watchlistMovies.execute()).thenAnswer(
            (_) async => Left<Failure, List<Movie>>(ServerFailure('failed')));
  }

  group('test', () {
    test('init state', () async {
      final actual = watchlistBloc.state;
      final matcher = WatchlistInitial();
      expect(actual, matcher);
    });

    test('test event', () async {
      final actual = WatchlistEvent();
      final matcher = WatchlistEvent();
      expect(actual.hashCode, matcher.hashCode);
    });

    group('bloc test', () {
      blocTest(
        'no event added',
        build: () => watchlistBloc,
        expect: () => [],
      );

      blocTest<WatchlistBloc, WatchlistState>('watchlist success',
          build: () {
            _mockWatchlistSuccess();
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(WatchlistEvent()),
          expect: () => [
            WatchlistLoading(),
            WatchlistLoaded(
                tvWatchlist: testTvList, movieWatchlist: testMovieList),
          ]);
      blocTest<WatchlistBloc, WatchlistState>('watchlist failed',
          build: () {
            _mockWatchlistFailed();
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(WatchlistEvent()),
          expect: () => [
            WatchlistLoading(),
            WatchlistError('Not found')
          ]);
    });
  });
}
