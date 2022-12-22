
import 'dart:developer';

import 'package:core/core.dart';
import 'package:movie/movie.dart';

import 'db/local_movie_database.dart';


abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final LocalMovieDatabase localMovieDatabase;

  MovieLocalDataSourceImpl({required this.localMovieDatabase});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await localMovieDatabase.insert(movie);
      return 'Added to Watchlist';
    } catch (e) {
      log('onInsertError($e)');
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await localMovieDatabase.remove(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await localMovieDatabase.getItemById(id);
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await localMovieDatabase.getItems();
    return result;
  }
}
