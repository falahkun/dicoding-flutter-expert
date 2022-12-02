import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/tv_use_case_mock.dart';

void main() {
  late TvUseCase tvUseCase;
  late TvDetailBloc tvDetailBloc;

  setUp(() {
    tvUseCase = MockTvUseCase();
    tvDetailBloc = TvDetailBloc(tvUseCase);
  });

  final tId = 1;

  void _mockGetTvDetailSuccess() {
    when(() => tvUseCase.getTvDetail(tId)).thenAnswer(
      (invocation) async => Right<Failure, TvDetail>(testTvDetail),
    );
  }

  void _mockGetTvDetailFailure() {
    when(() => tvUseCase.getTvDetail(tId)).thenAnswer(
      (invocation) async => Left<Failure, TvDetail>(
        ServerFailure('internal server error'),
      ),
    );
  }

  group('TvDetailBloc test', () {
    test('test initial state', () async {
      final bloc = TvDetailBloc(tvUseCase);
      final matcher = TvDetailInitial();
      final act = bloc.state;

      expect(act, matcher);
    });
  });

  group('TvDetailBloc test using bloctest', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'initialize without any event added',
      build: () => tvDetailBloc,
      expect: () => [],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'get tvDetail success',
      build: () {
        _mockGetTvDetailSuccess();
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(tId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailLoaded(testTvDetail),
      ],
    );
    blocTest<TvDetailBloc, TvDetailState>(
      'get tvDetail failure',
      build: () {
        _mockGetTvDetailFailure();
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(tId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailError('internal server error'),
      ],
    );
  });
}
