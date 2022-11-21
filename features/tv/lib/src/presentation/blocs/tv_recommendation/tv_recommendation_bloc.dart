import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_recommendation_event.dart';

part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  TvRecommendationBloc(this.useCase) : super(TvRecommendationInitial()) {
    on<GetTvRecommendationEvent>(_onGetTvRecommendationEvent);
  }

  final TvUseCase useCase;

  Future<void> _onGetTvRecommendationEvent(GetTvRecommendationEvent event,
      Emitter<TvRecommendationState> emit) async {
    emit(TvRecommendationLoading());
    final result = await useCase.getTvRecommendations(event.id);
    result.fold(
      (l) => emit(TvRecommendationError(l.message)),
      (result) => emit(TvRecommendationLoaded(result)),
    );
  }
}
