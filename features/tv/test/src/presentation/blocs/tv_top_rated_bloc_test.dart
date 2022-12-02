import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/tv_use_case_mock.dart';

void main() {
  late TvTopRatedBloc tvTopRatedBloc;
  late TvUseCase useCase;

  setUp(() {
    useCase = MockTvUseCase();
    tvTopRatedBloc = TvTopRatedBloc(useCase);
  });

  void _mockGetTopRatedTvSuccess() {
    when(() => useCase.getTopRatedTv()).thenAnswer(
      (_) async => Right<Failure, List<Tv>>(testTvList),
    );
  }

  void _mockGetTopRatedTvFailure() {
    when(() => useCase.getTopRatedTv()).thenAnswer(
      (_) async =>
          Left<Failure, List<Tv>>(ServerFailure('internal server error')),
    );
  }

  group('test', () {
    test('init', () async {
      final actual = tvTopRatedBloc.state;
      final matcher = TvTopRatedInitial();
      expect(actual, matcher);
    });
  });

  group('bloc test', () {
    blocTest(
      'when no event added',
      build: () => tvTopRatedBloc,
      expect: () => [],
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'when success',
      build: () {
        _mockGetTopRatedTvSuccess();
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(GetTvTopRatedEvent()),
      expect: () => [
        TvTopRatedLoading(),
        TvTopRatedLoaded(testTvList),
      ],
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'when failure',
      build: () {
        _mockGetTopRatedTvFailure();
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(GetTvTopRatedEvent()),
      expect: () => [
        TvTopRatedLoading(),
        TvTopRatedError('internal server error'),
      ],
    );
  });
}
