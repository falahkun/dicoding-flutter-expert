import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/src/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/src/presentation/blocs/blocs.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/tv_use_case_mock.dart';

void main() {
  late TvUseCase tvUseCase;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    tvUseCase = MockTvUseCase();
    watchlistTvBloc = WatchlistTvBloc(tvUseCase);
  });

  void _mockSaveTvWatchlistSuccess() {
    when(() => tvUseCase.saveTvWatchlist(testTvDetail)).thenAnswer(
      (_) async => Right<Failure, String>('tv saved to watchlist'),
    );
  }

  void _mockSaveTvWatchlistFailure() {
    when(() => tvUseCase.saveTvWatchlist(testTvDetail)).thenAnswer(
      (_) async => Left<Failure, String>(DatabaseFailure('tv already exists')),
    );
  }

  void _mockRemoveTvWatchlistSuccess() {
    when(() => tvUseCase.removeTvWatchlist(testTvDetail)).thenAnswer(
      (_) async => Right<Failure, String>('tv remove to watchlist'),
    );
  }

  void _mockRemoveTvWatchlistFailure() {
    when(() => tvUseCase.removeTvWatchlist(testTvDetail)).thenAnswer(
      (_) async => Left<Failure, String>(
        DatabaseFailure("tv doesn't exists"),
      ),
    );
  }

  group('test', () {
    test('testing initial state ', () async {
      final matcher = WatchlistTvInitial();
      final act = watchlistTvBloc.state;

      expect(act, matcher);
    });
  });

  group('watchlist tv bloc testing', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'when no event added',
      build: () {
        return watchlistTvBloc;
      },
      expect: () => [],
    );
    group('save to watchlist', () {
      blocTest<WatchlistTvBloc, WatchlistTvState>('when success',
          build: () {
            _mockSaveTvWatchlistSuccess();
            return watchlistTvBloc;
          },
          act: (bloc) => bloc.add(SaveToWatchlistTv(testTvDetail)),
          expect: () => [
                WatchlistTvLoading(),
                WatchlistTvSuccess(),
              ]);
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'when failure',
        build: () {
          _mockSaveTvWatchlistFailure();
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(SaveToWatchlistTv(testTvDetail)),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvError('tv already exists'),
        ],
      );
    });

    group('remove from watchlist', () {
      blocTest<WatchlistTvBloc, WatchlistTvState>('when success',
          build: () {
            _mockRemoveTvWatchlistSuccess();
            return watchlistTvBloc;
          },
          act: (bloc) => bloc.add(RemoveFromWatchlistTv(testTvDetail)),
          expect: () => [
                WatchlistTvLoading(),
                WatchlistTvSuccess(),
              ]);
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'when failure',
        build: () {
          _mockRemoveTvWatchlistFailure();
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlistTv(testTvDetail)),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvError("tv doesn't exists"),
        ],
      );
    });
  });
}
