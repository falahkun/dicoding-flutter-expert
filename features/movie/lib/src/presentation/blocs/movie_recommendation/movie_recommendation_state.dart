part of 'movie_recommendation_bloc.dart';

@immutable
abstract class MovieRecommendationState extends Equatable {}

class MovieRecommendationInitial extends MovieRecommendationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieRecommendationLoading extends MovieRecommendationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> movies;

  MovieRecommendationLoaded(this.movies);

  @override
  // TODO: implement props
  List<Object?> get props => [movies];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
