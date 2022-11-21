part of 'tv_watchlist_bloc.dart';

class TvWatchlistEvent extends Equatable {
  final int id;
  const TvWatchlistEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
