import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../../../dummy/movie_object.dart';
import '../../../../../helpers/test_movie_helper.mocks.dart';

void main() {
  late GetMovieDetail useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetMovieDetail(mockMovieRepository);
  });


  final tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(testMovieDetail));
  });
}