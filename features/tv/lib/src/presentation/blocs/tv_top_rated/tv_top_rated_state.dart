part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();
}

class TvTopRatedInitial extends TvTopRatedState {
  @override
  List<Object> get props => [];
}

class TvTopRatedLoading extends TvTopRatedState {
  @override
  List<Object> get props => [];
}

class TvTopRatedLoaded extends TvTopRatedState {
  final List<Tv> list;

  TvTopRatedLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class TvTopRatedError extends TvTopRatedState {
  final String message;

  TvTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
