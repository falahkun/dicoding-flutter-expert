import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../../../dummy/movie_object.dart';

class MockGetPopularMovies extends Mock
    implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
  });


  void _mockGetPopularMoviesSuccess() {
    when(() => mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Right<Failure, List<Movie>>(testMovieList),
    );
  }

  void _mockGetPopularMoviesFailure() {
    when(() => mockGetPopularMovies.execute()).thenAnswer(
          (_) async =>
          Left<Failure, List<Movie>>(ServerFailure('internal server error')),
    );
  }

  group('bloc test', () {
    test('should initial PopularState is correctly', () async {
      final bloc = PopularBloc(mockGetPopularMovies);
      final expectedState = PopularInitial();
      final actualState = bloc.state;

      expect(actualState, expectedState);
    });
  });

  group('initialize bloc', () {
    blocTest<PopularBloc, PopularState>(
      'initialize without any event added',
      build: () {
        return PopularBloc(mockGetPopularMovies);
      },
      expect: () => [
      ],
    );

    blocTest<PopularBloc, PopularState>(
      'when Success',
      build: () {
        _mockGetPopularMoviesSuccess();
        return PopularBloc(mockGetPopularMovies);
      },
      act: (bloc) => bloc.add(GetPopularMovieEvent()),
      expect: () => [
        PopularLoading(),
        PopularLoaded(testMovieList),
      ],
    );

    blocTest<PopularBloc, PopularState>(
      'when Error',
      build: () {
        _mockGetPopularMoviesFailure();
        return PopularBloc(mockGetPopularMovies);
      },
      act: (bloc) => bloc.add(GetPopularMovieEvent()),
      expect: () => [
        PopularLoading(),
        PopularError('internal server error'),
      ],
    );
  });
}
