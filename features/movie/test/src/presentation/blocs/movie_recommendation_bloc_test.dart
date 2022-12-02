import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';

class MockGetMovieRecommendation extends Mock
    implements GetMovieRecommendations {}

void main() {
  late MockGetMovieRecommendation mockGetMovieRecommendation;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendation();
  });

  final tId = 1;

  void _mockGetMovieRecommendationSuccess() {
    when(() => mockGetMovieRecommendation.execute(tId)).thenAnswer(
      (_) async => Right<Failure, List<Movie>>(testMovieList),
    );
  }

  void _mockGetMovieDetailFailure() {
    when(() => mockGetMovieRecommendation.execute(tId)).thenAnswer(
      (_) async =>
          Left<Failure, List<Movie>>(ServerFailure('internal server error')),
    );
  }

  group('MovieRecommendationBloc test', () {
    test('should initial MovieRecommendationState is correctly', () async {
      final bloc = MovieRecommendationBloc(mockGetMovieRecommendation);
      final expectedState = MovieRecommendationInitial();
      final actualState = bloc.state;

      expect(actualState, expectedState);
    });
  });

  group('initialize MovieRecommendationBloc', () {
    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'initialize without any event added',
      build: () {
        return MovieRecommendationBloc(mockGetMovieRecommendation);
      },
      expect: () => [
      ],
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'when GetMovieRecommendation Success',
      build: () {
        _mockGetMovieRecommendationSuccess();
        return MovieRecommendationBloc(mockGetMovieRecommendation);
      },
      act: (bloc) => bloc.add(GetMovieRecommendationEvent(tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationLoaded(testMovieList),
      ],
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'when GetMovieRecommendation Error',
      build: () {
        _mockGetMovieDetailFailure();
        return MovieRecommendationBloc(mockGetMovieRecommendation);
      },
      act: (bloc) => bloc.add(GetMovieRecommendationEvent(tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationError('internal server error'),
      ],
    );
  });
}
