part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();
}

class TvPopularInitial extends TvPopularState {
  @override
  List<Object> get props => [];
}

class TvPopularLoading extends TvPopularState {
  @override
  List<Object> get props => [];
}

class TvPopularLoaded extends TvPopularState {
  final List<Tv> list;

  TvPopularLoaded(this.list);
  @override
  List<Object> get props => [list];
}

class TvPopularError extends TvPopularState {
  final String message;

  TvPopularError(this.message);
  @override
  List<Object> get props => [message];
}
