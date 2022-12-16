import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';


part 'top_rated_event.dart';

part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  TopRatedBloc(this.getTopRatedMovies) : super(TopRatedInitial()) {
    on<GetTopRatedMovieEvent>(_onGetTopRatedMovieEvent);
  }

  final GetTopRatedMovies getTopRatedMovies;

  Future<void> _onGetTopRatedMovieEvent(
      GetTopRatedMovieEvent event, Emitter<TopRatedState> emit) async {
    emit(TopRatedLoading());
    try {
      final result = await getTopRatedMovies.execute();
      result.fold(
            (failure) => emit(TopRatedError(failure.message)),
            (result) => emit(TopRatedLoaded(result)),
      );
    } on SocketException {
      emit(TopRatedError('connection failed, please try again or update your app!'));
    } catch (err) {
      emit(TopRatedError('something error!'));
    }
  }
}
