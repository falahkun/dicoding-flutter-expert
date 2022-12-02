import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/tv_use_case_mock.dart';

void main() {
  late TvPopularBloc tvPopularBloc;
  late TvUseCase useCase;

  setUp(() {
    useCase = MockTvUseCase();
    tvPopularBloc = TvPopularBloc(useCase);
  });

  void _mockGetPopularTvSuccess() {
    when(() => useCase.getPopularTv()).thenAnswer(
          (_) async => Right<Failure, List<Tv>>(testTvList),
    );
  }

  void _mockGetPopularTvFailure() {
    when(() => useCase.getPopularTv()).thenAnswer(
          (_) async =>
          Left<Failure, List<Tv>>(ServerFailure('internal server error')),
    );
  }

  group('test', () {
    test('init', () async {
      final actual = tvPopularBloc.state;
      final matcher = TvPopularInitial();
      expect(actual, matcher);
    });
  });

  group('bloc test', () {
    blocTest(
      'when no event added',
      build: () => tvPopularBloc,
      expect: () => [],
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'when success',
      build: () {
        _mockGetPopularTvSuccess();
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(GetTvPopularEvent()),
      expect: () => [
        TvPopularLoading(),
        TvPopularLoaded(testTvList),
      ],
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'when failure',
      build: () {
        _mockGetPopularTvFailure();
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(GetTvPopularEvent()),
      expect: () => [
        TvPopularLoading(),
        TvPopularError('internal server error'),
      ],
    );
  });
}
