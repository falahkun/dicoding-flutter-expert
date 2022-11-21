part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationState extends Equatable {
  const TvRecommendationState();
}

class TvRecommendationInitial extends TvRecommendationState {
  @override
  List<Object> get props => [];
}

class TvRecommendationLoading extends TvRecommendationState {
  @override
  List<Object> get props => [];
}

class TvRecommendationLoaded extends TvRecommendationState {
  final List<Tv> list;

  TvRecommendationLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class TvRecommendationError extends TvRecommendationState {
  final String message;

  TvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
