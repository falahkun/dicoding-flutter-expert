part of 'watchlist_movie_bloc.dart';

@immutable
abstract class WatchlistMovieEvent {}

class SaveMovieToWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  SaveMovieToWatchlist(this.movie);
}

class RemoveMovieFromWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  RemoveMovieFromWatchlist(this.movie);
}