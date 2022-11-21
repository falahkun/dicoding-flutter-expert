part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedState extends Equatable {}

class TopRatedInitial extends TopRatedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TopRatedLoading extends TopRatedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TopRatedLoaded extends TopRatedState {
  final List<Movie> list;

  TopRatedLoaded(this.list);
  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
class TopRatedError extends TopRatedState {
  final String message;

  TopRatedError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
