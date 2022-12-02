
import 'package:flutter_test/flutter_test.dart';

import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/movie_object.dart';
import '../../../helpers/movie_repository_mock.dart';
import 'package:mocktail/mocktail.dart';


void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlist(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(() => mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(() => mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
