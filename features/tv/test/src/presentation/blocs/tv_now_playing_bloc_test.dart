import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/tv_use_case_mock.dart';

void main() {
  late TvNowPlayingBloc tvNowPlayingBloc;
  late TvUseCase useCase;

  setUp(() {
    useCase = MockTvUseCase();
    tvNowPlayingBloc = TvNowPlayingBloc(useCase);
  });

  void _mockGetNowPlayingTvSuccess() {
    when(() => useCase.getNowPlayingTv()).thenAnswer(
          (_) async => Right<Failure, List<Tv>>(testTvList),
    );
  }

  void _mockGetNowPlayingTvFailure() {
    when(() => useCase.getNowPlayingTv()).thenAnswer(
          (_) async =>
          Left<Failure, List<Tv>>(ServerFailure('internal server error')),
    );
  }

  group('test', () {
    test('init', () async {
      final actual = tvNowPlayingBloc.state;
      final matcher = TvNowPlayingInitial();
      expect(actual, matcher);
    });
  });

  group('bloc test', () {
    blocTest(
      'when no event added',
      build: () => tvNowPlayingBloc,
      expect: () => [],
    );

    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      'when success',
      build: () {
        _mockGetNowPlayingTvSuccess();
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(GetTvNowPlaying()),
      expect: () => [
        TvNowPlayingLoading(),
        TvNowPlayingLoaded(testTvList),
      ],
    );

    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      'when failure',
      build: () {
        _mockGetNowPlayingTvFailure();
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(GetTvNowPlaying()),
      expect: () => [
        TvNowPlayingLoading(),
        TvNowPlayingError('internal server error'),
      ],
    );
  });
}
