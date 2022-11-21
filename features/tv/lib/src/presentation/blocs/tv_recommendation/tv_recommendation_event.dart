part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationEvent extends Equatable {
  const TvRecommendationEvent();
}

class GetTvRecommendationEvent extends TvRecommendationEvent {
  final int id;

  GetTvRecommendationEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}