import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';

class MockGetMovieNowPlaying extends Mock
    implements GetNowPlayingMovies {}

void main() {
  late MockGetMovieNowPlaying mockGetMovieNowPlaying;

  setUp(() {
    mockGetMovieNowPlaying = MockGetMovieNowPlaying();
  });


  void _mockGetMovieNowPlayingSuccess() {
    when(() => mockGetMovieNowPlaying.execute()).thenAnswer(
          (_) async => Right<Failure, List<Movie>>(testMovieList),
    );
  }

  void _mockGetMovieDetailFailure() {
    when(() => mockGetMovieNowPlaying.execute()).thenAnswer(
          (_) async =>
          Left<Failure, List<Movie>>(ServerFailure('internal server error')),
    );
  }

  group('bloc test', () {
    test('should initial NowPlayingState is correctly', () async {
      final bloc = NowPlayingBloc(mockGetMovieNowPlaying);
      final expectedState = NowPlayingInitial();
      final actualState = bloc.state;

      expect(actualState, expectedState);
    });
  });

  group('initialize bloc', () {
    blocTest<NowPlayingBloc, NowPlayingState>(
      'initialize without any event added',
      build: () {
        return NowPlayingBloc(mockGetMovieNowPlaying);
      },
      expect: () => [
      ],
    );

    blocTest<NowPlayingBloc, NowPlayingState>(
      'when Success',
      build: () {
        _mockGetMovieNowPlayingSuccess();
        return NowPlayingBloc(mockGetMovieNowPlaying);
      },
      act: (bloc) => bloc.add(GetMovieNowPlaying()),
      expect: () => [
        NowPlayingLoading(),
        NowPlayingLoaded(testMovieList),
      ],
    );

    blocTest<NowPlayingBloc, NowPlayingState>(
      'when Error',
      build: () {
        _mockGetMovieDetailFailure();
        return NowPlayingBloc(mockGetMovieNowPlaying);
      },
      act: (bloc) => bloc.add(GetMovieNowPlaying()),
      expect: () => [
        NowPlayingLoading(),
        NowPlayingError('internal server error'),
      ],
    );
  });
}
