import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../../../dummy/movie_object.dart';
import 'db/test_local_movie_database.mocks.dart';

void main() {
  late LocalMovieDatabase localMovieDatabase;
  late MovieLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    localMovieDatabase = MockLocalMovieDatabase();
    dataSourceImpl =
        MovieLocalDataSourceImpl(localMovieDatabase: localMovieDatabase);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(localMovieDatabase.insert(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceImpl.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(localMovieDatabase.insert(testMovieTable)).thenThrow(Exception());
      // act
      final call = dataSourceImpl.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(localMovieDatabase.remove(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceImpl.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(localMovieDatabase.remove(testMovieTable)).thenThrow(Exception());
      // act
      final call = dataSourceImpl.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(localMovieDatabase.getItemById(tId))
          .thenAnswer((_) async => MovieTable.fromMap(testMovieMap));
      // act
      final result = await dataSourceImpl.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(localMovieDatabase.getItemById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSourceImpl.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(localMovieDatabase.getItems())
          .thenAnswer((_) async => [MovieTable.fromMap(testMovieMap)]);
      // act
      final result = await dataSourceImpl.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
