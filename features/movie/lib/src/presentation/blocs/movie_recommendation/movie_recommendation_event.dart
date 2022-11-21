part of 'movie_recommendation_bloc.dart';

@immutable
abstract class MovieRecommendationEvent {}

class GetMovieRecommendationEvent extends MovieRecommendationEvent {
  final int id;

  GetMovieRecommendationEvent(this.id);
}