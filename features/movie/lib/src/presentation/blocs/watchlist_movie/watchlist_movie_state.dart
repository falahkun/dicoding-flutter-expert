part of 'watchlist_movie_bloc.dart';

@immutable
abstract class WatchlistMovieState extends Equatable {}

class WatchlistMovieInitial extends WatchlistMovieState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchlistMovieLoading extends WatchlistMovieState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchlistMovieSuccess extends WatchlistMovieState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
