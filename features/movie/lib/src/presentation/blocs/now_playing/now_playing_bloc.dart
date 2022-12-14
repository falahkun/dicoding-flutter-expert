// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';


part 'now_playing_event.dart';

part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc(this.getNowPlayingMovies) : super(NowPlayingInitial()) {
    on<GetMovieNowPlaying>(_onGetMovieNowPlaying);
  }

  final GetNowPlayingMovies getNowPlayingMovies;

  Future<void> _onGetMovieNowPlaying(
      GetMovieNowPlaying event, Emitter<NowPlayingState> emit) async {
    emit(NowPlayingLoading());
    try {
      final result = await getNowPlayingMovies.execute();
      result.fold(
            (failure) => emit(NowPlayingError(failure.message)),
            (result) => emit(NowPlayingLoaded(result)),
      );
    } on SocketException {
      emit(NowPlayingError('connection failed, please try again or update your app!'));
    } catch (err) {
      emit(NowPlayingError('something error!'));
    }
  }
}
