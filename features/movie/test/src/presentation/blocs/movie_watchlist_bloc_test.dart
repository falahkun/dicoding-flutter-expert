import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';


class MockGetWatchlistStatus extends Mock
    implements GetWatchListStatus {}

void main() {
  late MockGetWatchlistStatus mockGetWatchlistStatus;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchlistStatus();
  });

  final tId = 1;

  void _mockGetWatchlistStatusSuccess() {
    when(() => mockGetWatchlistStatus.execute(tId)).thenAnswer(
          (_) async => true,
    );
  }

  void _mockGetMovieDetailFailure() {
    when(() => mockGetWatchlistStatus.execute(tId)).thenAnswer(
          (_) async => false,
    );
  }

  group('bloc test', () {
    test('should initial state is correctly', () async {
      final bloc = MovieWatchlistBloc(mockGetWatchlistStatus);
      final expectedState = MovieWatchlistState(false);
      final actualState = bloc.state;

      expect(actualState, expectedState);
    });
  });

  group('initialize bloc', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'initialize without any event added',
      build: () {
        return MovieWatchlistBloc(mockGetWatchlistStatus);
      },
      expect: () => [
      ],
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'when Success',
      build: () {
        _mockGetWatchlistStatusSuccess();
        return MovieWatchlistBloc(mockGetWatchlistStatus);
      },
      act: (bloc) => bloc.add(MovieWatchlistEvent(tId)),
      expect: () => [
        MovieWatchlistState(true),
      ],
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'when Error',
      build: () {
        _mockGetMovieDetailFailure();
        return MovieWatchlistBloc(mockGetWatchlistStatus);
      },
      act: (bloc) => bloc.add(MovieWatchlistEvent(tId)),
      expect: () => [
        MovieWatchlistState(false),
      ],
    );
  });
}
