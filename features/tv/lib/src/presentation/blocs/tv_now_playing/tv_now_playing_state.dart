part of 'tv_now_playing_bloc.dart';

abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();
}

class TvNowPlayingInitial extends TvNowPlayingState {
  @override
  List<Object> get props => [];
}

class TvNowPlayingLoading extends TvNowPlayingState {
  @override
  List<Object> get props => [];
}

class TvNowPlayingLoaded extends TvNowPlayingState {
  final List<Tv> list;

  TvNowPlayingLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class TvNowPlayingError extends TvNowPlayingState {
  final String message;

  TvNowPlayingError(this.message);
  @override
  List<Object> get props => [message];
}
