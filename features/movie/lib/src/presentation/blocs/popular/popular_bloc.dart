// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';


part 'popular_event.dart';

part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc(this.getPopularMovies) : super(PopularInitial()) {
    on<GetPopularMovieEvent>(_onGetPopularMovieEvent);
  }

  final GetPopularMovies getPopularMovies;

  Future<void> _onGetPopularMovieEvent(
      GetPopularMovieEvent event, Emitter<PopularState> emit) async {
    emit(PopularLoading());
    final result = await getPopularMovies.execute();

    result.fold(
      (failure) => emit(PopularError(failure.message)),
      (result) => emit(PopularLoaded(result)),
    );
  }
}
