import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
  });

  final tId = 1;

  void _mockGetMovieDetailSuccess() {
    when(() => mockGetMovieDetail.execute(tId)).thenAnswer(
      (_) async => Right<Failure, MovieDetail>(testMovieDetail),
    );
  }

  void _mockGetMovieDetailFailure() {
    when(() => mockGetMovieDetail.execute(tId)).thenAnswer(
      (_) async =>
          Left<Failure, MovieDetail>(ServerFailure('internal server error')),
    );
  }

  group('MovieDetailBloc test', () {
    test('Watchlist button should display add icon when movie not added to watchlist', () async {
      final movieDetailBloc = MovieDetailBloc(MockGetMovieDetail());
      final expectedState = MovieDetailInitial();
      final actualState = movieDetailBloc.state;

      expect(actualState, expectedState);
    });
  });

  group('initialize MovieDetail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'initialize without any event added',
      build: () {
        return MovieDetailBloc(mockGetMovieDetail);
      },
      expect: () => [],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'when GetMovieDetail Success',
      build: () {
        _mockGetMovieDetailSuccess();
        return MovieDetailBloc(mockGetMovieDetail);
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailLoaded(testMovieDetail),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'when GetMovieDetail Error',
      build: () {
        _mockGetMovieDetailFailure();
        return MovieDetailBloc(mockGetMovieDetail);
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError('internal server error'),
      ],
    );
  });
}
