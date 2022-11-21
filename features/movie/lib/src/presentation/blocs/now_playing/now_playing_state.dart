part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {}

class NowPlayingInitial extends NowPlayingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class NowPlayingLoading extends NowPlayingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class NowPlayingLoaded extends NowPlayingState {
  final List<Movie> list;

  NowPlayingLoaded(this.list);
  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
class NowPlayingError extends NowPlayingState {
  final String message;

  NowPlayingError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
