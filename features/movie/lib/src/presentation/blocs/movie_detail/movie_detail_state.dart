
part of 'movie_detail_bloc.dart';


@immutable
abstract class MovieDetailState extends Equatable {}

class MovieDetailInitial extends MovieDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class MovieDetailLoading extends MovieDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailLoaded(this.movieDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [movieDetail];
}
class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
