import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_usecase.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([
  TvUseCaseImpl,
])
void main() {
  late WatchlistTvNotifier provider;
  late TvUseCaseImpl useCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    useCase = MockTvUseCaseImpl();
    provider = WatchlistTvNotifier(
      useCase: useCase
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(useCase.getWatchlistTv())
        .thenAnswer((_) async => Right([testWatchlistTv]));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTv, [testWatchlistTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(useCase.getWatchlistTv())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
