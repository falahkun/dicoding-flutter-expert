part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {}

class PopularInitial extends PopularState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PopularLoading extends PopularState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PopularLoaded extends PopularState {
  final List<Movie> list;

  PopularLoaded(this.list);

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}

class PopularError extends PopularState {
  final String message;

  PopularError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
