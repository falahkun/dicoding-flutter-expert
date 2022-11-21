part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();
}

class WatchlistTvInitial extends WatchlistTvState {
  @override
  List<Object> get props => [];
}

class WatchlistTvLoading extends WatchlistTvState {
  @override
  List<Object> get props => [];
}

class WatchlistTvSuccess extends WatchlistTvState {
  @override
  List<Object> get props => [];
}
class WatchlistTvError extends WatchlistTvState {
  final String message;

  WatchlistTvError(this.message);
  @override
  List<Object> get props => [message];
}
