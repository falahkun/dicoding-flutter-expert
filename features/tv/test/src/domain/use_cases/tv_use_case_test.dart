import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../dummy/tv_objects.dart';

class MockTvRepository extends Mock implements TvRepository {}

void main() {
  late TvUseCaseImpl useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = TvUseCaseImpl(repository: mockTvRepository);
  });

  final tTv = <Tv>[];
  final tQuery = 'Pasión de gavilanes';

  test('should get list of tv from the repository', () async {
    // arrange
    when(() => mockTvRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await useCase.searchTv(tQuery);
    // assert
    expect(result, Right(tTv));
  });
  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(() => mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await useCase.getTvDetail(tId);
    // assert
    expect(result, Right(testTvDetail));
  });

  test('should get list of tv recommendations from the repository',
          () async {
        // arrange
        when(() => mockTvRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await useCase.getTvRecommendations(tId);
        // assert
        expect(result, Right(tTv));
      });

  final tTvs = <Tv>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(() => mockTvRepository.getNowPlayingTv())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await useCase.getNowPlayingTv();
    // assert
    expect(result, Right(tTvs));
  });

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
              () async {
            // arrange
            when(() => mockTvRepository.getPopularTv())
                .thenAnswer((_) async => Right(tTvs));
            // act
            final result = await useCase.getPopularTv();
            // assert
            expect(result, Right(tTvs));
          });
    });
  });

  test('should get list of tv from repository', () async {
    // arrange
    when(() => mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await useCase.getTopRatedTv();
    // assert
    expect(result, Right(tTvs));
  });

  test('should get list of tv from the repository', () async {
    // arrange
    when(() => mockTvRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await useCase.getWatchlistTv();
    // assert
    expect(result, Right(testTvList));
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(() => mockTvRepository.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await useCase.removeTvWatchlist(testTvDetail);
    // assert
    verify(() => mockTvRepository.removeTvWatchlist(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });

  test('should save tv to the repository', () async {
    // arrange
    when(() => mockTvRepository.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await useCase.saveTvWatchlist(testTvDetail);
    // assert
    verify(() => mockTvRepository.saveTvWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
