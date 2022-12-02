
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/movie_object.dart';
import '../../../helpers/movie_repository_mock.dart';

void main() {
  late SaveWatchlist useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = SaveWatchlist(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(() => mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await useCase.execute(testMovieDetail);
    // assert
    verify(() => mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });
}