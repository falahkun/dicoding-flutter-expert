import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_event.dart';

part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  MovieRecommendationBloc(this.getMovieRecommendations)
      : super(MovieRecommendationInitial()) {
    on<GetMovieRecommendationEvent>(_onGetMovieRecommendationEvent);
  }

  final GetMovieRecommendations getMovieRecommendations;

  Future<void> _onGetMovieRecommendationEvent(GetMovieRecommendationEvent event,
      Emitter<MovieRecommendationState> emit) async {
    emit(MovieRecommendationLoading());
    final result = await getMovieRecommendations.execute(event.id);
    result.fold(
      (failure) => emit(MovieRecommendationError(failure.message)),
      (result) => emit(MovieRecommendationLoaded(result)),
    );
  }
}
