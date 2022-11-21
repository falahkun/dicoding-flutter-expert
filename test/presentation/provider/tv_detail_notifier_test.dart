import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  TvUseCaseImpl,
])
void main() {
  late TvDetailNotifier provider;
  late TvUseCaseImpl useCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    useCase = MockTvUseCaseImpl();
    provider = TvDetailNotifier(
      useCase: useCase,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final testTv = Tv(
    firstAirDate: "2003-10-21",
    name: "Pasión de gavilanes",
    originalLanguage: "en",
    originalName:"Pasión de gavilanes",
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTv = <Tv>[testTv];

  void _arrangeUseCase() {
    when(useCase.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(useCase.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(useCase.getTvDetail(tId));
      verify(useCase.getTvRecommendations(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUseCase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTv);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(useCase.getTvRecommendations(tId));
      expect(provider.tvRecommendations, tTv);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTv);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(useCase.getTvDetail(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(useCase.getTvRecommendations(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(useCase.isAddedToWatchlist(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(useCase.saveTvWatchlist(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(useCase.isAddedToWatchlist(testTvDetail.id!))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(useCase.saveTvWatchlist(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(useCase.removeTvWatchlist(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(useCase.isAddedToWatchlist(testTvDetail.id!))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(useCase.removeTvWatchlist(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(useCase.saveTvWatchlist(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(useCase.isAddedToWatchlist(testTvDetail.id!))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(useCase.isAddedToWatchlist(testTvDetail.id!));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(useCase.saveTvWatchlist(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(useCase.isAddedToWatchlist(testTvDetail.id!))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(useCase.getTvDetail(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(useCase.getTvRecommendations(tId))
          .thenAnswer((_) async => Right(tTv));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
