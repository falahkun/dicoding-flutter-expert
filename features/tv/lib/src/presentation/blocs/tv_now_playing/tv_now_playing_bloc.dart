import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_now_playing_event.dart';

part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  TvNowPlayingBloc(this.useCase) : super(TvNowPlayingInitial()) {
    on<GetTvNowPlaying>(_onGetTvNowPlaying);
  }

  final TvUseCase useCase;

  Future<void> _onGetTvNowPlaying(
      GetTvNowPlaying event, Emitter<TvNowPlayingState> emit) async {
    emit(TvNowPlayingLoading());
    try {
      final result = await useCase.getNowPlayingTv();
      result.fold((failure) => emit(TvNowPlayingError(failure.message)),
              (result) => emit(TvNowPlayingLoaded(result)));
    } on SocketException {
      emit(TvNowPlayingError('connection failed, please try again or update your app!'));
    } catch (err) {
      emit(TvNowPlayingError('something error!'));
    }
  }
}
