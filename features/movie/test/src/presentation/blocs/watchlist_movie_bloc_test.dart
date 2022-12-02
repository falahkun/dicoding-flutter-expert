import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';

class MockSaveMovieWatchlist extends Mock implements SaveWatchlist {}

class MockRemoveMovieWatchlist extends Mock implements RemoveWatchlist {}

void main() {
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;

  setUp(() {
    mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
  });

  void _mockSaveMovieWatchlistSuccess() {
    when(() => mockSaveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
      (_) async => Right<Failure, String>('movie saved to watchlist'),
    );
  }

  void _mockSaveMovieWatchlistFailure() {
    when(() => mockSaveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
      (_) async =>
          Left<Failure, String>(DatabaseFailure('movie already exists')),
    );
  }

  void _mockRemoveMovieWatchlistSuccess() {
    when(() => mockRemoveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
      (_) async => Right<Failure, String>('movie removed from watchlist'),
    );
  }

  void _mockRemoveMovieWatchlistFailure() {
    when(() => mockRemoveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
      (_) async =>
          Left<Failure, String>(DatabaseFailure("movie doesn't exists")),
    );
  }

  group('bloc test', () {
    test('should initial WatchlistMovieState is correctly', () async {
      final bloc = WatchlistMovieBloc(
          removeWatchlist: mockRemoveMovieWatchlist,
          saveWatchlist: mockSaveMovieWatchlist);
      final expectedState = WatchlistMovieInitial();
      final actualState = bloc.state;

      expect(actualState, expectedState);
    });
  });

  group('initialize bloc', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'initialize without any event added',
      build: () {
        return WatchlistMovieBloc(
          removeWatchlist: mockRemoveMovieWatchlist,
          saveWatchlist: mockSaveMovieWatchlist,
        );
      },
      expect: () => [],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'when save Success',
      build: () {
        _mockSaveMovieWatchlistSuccess();
        return WatchlistMovieBloc(
          removeWatchlist: mockRemoveMovieWatchlist,
          saveWatchlist: mockSaveMovieWatchlist,
        );
      },
      act: (bloc) => bloc.add(SaveMovieToWatchlist(testMovieDetail)),
      expect: () => [
        // WatchlistMovieLoading(),
        WatchlistMovieSuccess(),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'when save failure',
      build: () {
        _mockSaveMovieWatchlistFailure();
        return WatchlistMovieBloc(
          removeWatchlist: mockRemoveMovieWatchlist,
          saveWatchlist: mockSaveMovieWatchlist,
        );
      },
      act: (bloc) => bloc.add(SaveMovieToWatchlist(testMovieDetail)),
      expect: () => [
        // WatchlistMovieLoading(),
        WatchlistMovieError('movie already exists'),
      ],
    );


    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'when remove Success',
      build: () {
        _mockRemoveMovieWatchlistSuccess();
        return WatchlistMovieBloc(
          removeWatchlist: mockRemoveMovieWatchlist,
          saveWatchlist: mockSaveMovieWatchlist,
        );
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        // WatchlistMovieLoading(),
        WatchlistMovieSuccess(),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'when remove failure',
      build: () {
        _mockRemoveMovieWatchlistFailure();
        return WatchlistMovieBloc(
          removeWatchlist: mockRemoveMovieWatchlist,
          saveWatchlist: mockSaveMovieWatchlist,
        );
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        // WatchlistMovieLoading(),
        WatchlistMovieError("movie doesn't exists"),
      ],
    );

  });
}
