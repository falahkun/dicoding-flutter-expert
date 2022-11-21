import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([
  TvUseCaseImpl,
])
void main() {
  late TvSearchNotifier provider;
  late TvUseCaseImpl useCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    useCase = MockTvUseCaseImpl();
    provider = TvSearchNotifier(useCase:useCase)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

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
  
  final tTvList = <Tv>[testTv];
  final tQuery = 'Pasión de gavilanes';

  group('search tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(useCase.searchTv(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
            () async {
          // arrange
          when(useCase.searchTv(tQuery))
              .thenAnswer((_) async => Right(tTvList));
          // act
          await provider.fetchTvSearch(tQuery);
          // assert
          expect(provider.state, RequestState.Loaded);
          expect(provider.searchResult, tTvList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(useCase.searchTv(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
