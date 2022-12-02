import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';

class MockGetTopRatedMovies extends Mock
    implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
  });


  void _mockGetTopRatedMoviesSuccess() {
    when(() => mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Right<Failure, List<Movie>>(testMovieList),
    );
  }

  void _mockGetTopRatedMoviesFailure() {
    when(() => mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async =>
          Left<Failure, List<Movie>>(ServerFailure('internal server error')),
    );
  }

  group('bloc test', () {
    test('should initial TopRatedState is correctly', () async {
      final bloc = TopRatedBloc(mockGetTopRatedMovies);
      final expectedState = TopRatedInitial();
      final actualState = bloc.state;

      expect(actualState, expectedState);
    });
  });

  group('initialize bloc', () {
    blocTest<TopRatedBloc, TopRatedState>(
      'initialize without any event added',
      build: () {
        return TopRatedBloc(mockGetTopRatedMovies);
      },
      expect: () => [
      ],
    );

    blocTest<TopRatedBloc, TopRatedState>(
      'when Success',
      build: () {
        _mockGetTopRatedMoviesSuccess();
        return TopRatedBloc(mockGetTopRatedMovies);
      },
      act: (bloc) => bloc.add(GetTopRatedMovieEvent()),
      expect: () => [
        TopRatedLoading(),
        TopRatedLoaded(testMovieList),
      ],
    );

    blocTest<TopRatedBloc, TopRatedState>(
      'when Error',
      build: () {
        _mockGetTopRatedMoviesFailure();
        return TopRatedBloc(mockGetTopRatedMovies);
      },
      act: (bloc) => bloc.add(GetTopRatedMovieEvent()),
      expect: () => [
        TopRatedLoading(),
        TopRatedError('internal server error'),
      ],
    );
  });
}
