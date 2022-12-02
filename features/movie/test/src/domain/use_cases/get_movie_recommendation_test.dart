
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../helpers/movie_repository_mock.dart';



void main() {
  late GetMovieRecommendations usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tMovies = <Movie>[];

  test('should get list of movie recommendations from the repository',
          () async {
        // arrange
        when(() => mockMovieRepository.getMovieRecommendations(tId))
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tMovies));
      });
}
