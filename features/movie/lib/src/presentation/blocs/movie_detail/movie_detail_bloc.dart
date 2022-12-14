// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';


part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailInitial()) {
    on<GetMovieDetailEvent>(_onGetMovieDetailEvent);
  }

  final GetMovieDetail getMovieDetail;

  Future<void> _onGetMovieDetailEvent(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try {
      final result = await getMovieDetail.execute(event.id);
      result.fold(
            (failure) => emit(MovieDetailError(failure.message)),
            (result) => emit(MovieDetailLoaded(result)),
      );
    } on SocketException {
      emit(MovieDetailError('connection failed, please try again or update your app!'));
    } catch (err) {
      emit(MovieDetailError('something error!'));
    }
  }
}
