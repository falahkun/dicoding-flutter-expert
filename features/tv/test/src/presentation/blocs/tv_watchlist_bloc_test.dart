import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../helpers/tv_use_case_mock.dart';

void main() {
  late TvUseCase useCase;
  late TvWatchlistBloc tvWatchlistBloc;

  setUp(() {
    useCase = MockTvUseCase();
    tvWatchlistBloc = TvWatchlistBloc(useCase);
  });

  final tId = 1;

  void _mockGetWatchlistStatusSuccess() {
    when(() => useCase.isAddedToWatchlist(tId)).thenAnswer(
      (_) async => true,
    );
  }

  void _mockGetWatchlistStatusFailure() {
    when(() => useCase.isAddedToWatchlist(tId)).thenAnswer(
      (_) async => false,
    );
  }

  group('test', () {
    test('init state', () async {
      final actual = tvWatchlistBloc.state;
      final matcher = TvWatchlistState(false);

      expect(actual, matcher);
    });
  });

  group('bloc test', () {
    blocTest(
      'when no event added',
      build: () => tvWatchlistBloc,
      expect: () => [],
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'when true',
      build: () {
        _mockGetWatchlistStatusSuccess();
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(
        TvWatchlistEvent(tId),
      ),
      expect: () => [
        TvWatchlistState(true)
      ],
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'when false',
      build: () {
        _mockGetWatchlistStatusFailure();
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(
        TvWatchlistEvent(tId),
      ),
      expect: () => [
        TvWatchlistState(false)
      ],
    );
  });
}
