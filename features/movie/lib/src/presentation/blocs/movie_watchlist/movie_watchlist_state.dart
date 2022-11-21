part of 'movie_watchlist_bloc.dart';

@immutable
class MovieWatchlistState extends Equatable {
  final bool isWatchlistExists;

  const MovieWatchlistState(this.isWatchlistExists);

  @override
  // TODO: implement props
  List<Object?> get props => [isWatchlistExists];
}
