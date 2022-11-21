part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();
}

class SaveToWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  SaveToWatchlistTv(this.tvDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvDetail];
}


class RemoveFromWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  RemoveFromWatchlistTv(this.tvDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvDetail];
}
