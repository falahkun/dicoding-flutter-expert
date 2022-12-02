part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
}

class WatchlistInitial extends WatchlistState {
  @override
  List<Object> get props => [];
}

class WatchlistLoading extends WatchlistState {
  @override
  List<Object> get props => [];
}

class WatchlistLoaded extends WatchlistState {
  final List<Tv> tvWatchlist;
  final List<Movie> movieWatchlist;

  WatchlistLoaded({
    required this.tvWatchlist,
    required this.movieWatchlist,
  });

  @override
  List<Object> get props => [
        tvWatchlist,
        movieWatchlist,
      ];
}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);
  @override
  List<Object> get props => [message];
}
