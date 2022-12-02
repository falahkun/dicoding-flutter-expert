import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy/movie_object.dart';
import '../../../dummy/tv_objects.dart';

class MockTvUseCase extends Mock implements TvUseCase {}

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late TvUseCase tvUseCase;
  late SearchMovies searchMovies;

  late SearchBloc searchBloc;

  setUp(() {
    tvUseCase = MockTvUseCase();
    searchMovies = MockSearchMovies();
    searchBloc = SearchBloc(
      tvUseCase: tvUseCase,
      searchMovies: searchMovies,
    );
  });

  void _mockSearchSuccess() {
    when(() => tvUseCase.searchTv('test')).thenAnswer(
      (_) async => Right<Failure, List<Tv>>(testTvList),
    );
    when(() => searchMovies.execute('test'))
        .thenAnswer((_) async => Right<Failure, List<Movie>>(testMovieList));
  }

  void _mockSearchFailed() {
    when(() => tvUseCase.searchTv('test')).thenAnswer(
      (_) async => Left<Failure, List<Tv>>(ServerFailure('failed')),
    );
    when(() => searchMovies.execute('test')).thenAnswer(
        (_) async => Left<Failure, List<Movie>>(ServerFailure('failed')));
  }

  group('test', () {
    group('testing ', () {
      test('init state', () async {
        final actual = searchBloc.state;
        final matcher = SearchInitial();
        expect(actual, matcher);
      });

      test('test event', () async {
        final actual = SearchEvent('test');
        final matcher = SearchEvent('test');

        expect(actual.props, matcher.props);
      });
    });

    group('bloc test', () {
      blocTest(
        'no event added',
        build: () => searchBloc,
        expect: () => [],
      );

      blocTest<SearchBloc, SearchState>('search success',
          build: () {
            _mockSearchSuccess();
            return searchBloc;
          },
          act: (bloc) => bloc.add(SearchEvent('test')),
          expect: () => [
                SearchLoading(),
                SearchLoaded(
                    tvResults: testTvList, movieResults: testMovieList),
              ]);
      blocTest<SearchBloc, SearchState>('search failed',
          build: () {
            _mockSearchFailed();
            return searchBloc;
          },
          act: (bloc) => bloc.add(SearchEvent('test')),
          expect: () => [
            SearchLoading(),
            SearchError('Not found')
          ]);
    });
  });
}
