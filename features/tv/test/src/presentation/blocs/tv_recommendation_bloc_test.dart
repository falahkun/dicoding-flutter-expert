import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/tv_use_case_mock.dart';

void main() {
  late TvRecommendationBloc tvRecommendationBloc;
  late TvUseCase useCase;

  final tId = 1;
  setUp(() {
    useCase = MockTvUseCase();
    tvRecommendationBloc = TvRecommendationBloc(useCase);
  });

  void _mockGetTopRatedTvSuccess() {
    when(() => useCase.getTvRecommendations(tId)).thenAnswer(
      (_) async => Right<Failure, List<Tv>>(testTvList),
    );
  }

  void _mockGetTopRatedTvFailure() {
    when(() => useCase.getTvRecommendations(tId)).thenAnswer(
      (_) async =>
          Left<Failure, List<Tv>>(ServerFailure('internal server error')),
    );
  }

  group('test', () {
    test('init', () async {
      final actual = tvRecommendationBloc.state;
      final matcher = TvRecommendationInitial();
      expect(actual, matcher);
    });
  });

  group('bloc test', () {
    blocTest(
      'when no event added',
      build: () => tvRecommendationBloc,
      expect: () => [],
    );

    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'when success',
      build: () {
        _mockGetTopRatedTvSuccess();
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(GetTvRecommendationEvent(tId)),
      expect: () => [
        TvRecommendationLoading(),
        TvRecommendationLoaded(testTvList),
      ],
    );

    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'when failure',
      build: () {
        _mockGetTopRatedTvFailure();
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(GetTvRecommendationEvent(tId)),
      expect: () => [
        TvRecommendationLoading(),
        TvRecommendationError('internal server error'),
      ],
    );
  });
}
