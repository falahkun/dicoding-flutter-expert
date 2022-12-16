import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  TvDetailBloc(this.useCase) : super(TvDetailInitial()) {
    on<GetTvDetailEvent>(_onGetTvDetailEvent);
  }

  final TvUseCase useCase;

  Future<void> _onGetTvDetailEvent(
      GetTvDetailEvent event, Emitter<TvDetailState> emit) async {
    emit(TvDetailLoading());
    try {
      final result = await useCase.getTvDetail(event.id);
      result.fold(
            (failure) => emit(TvDetailError(failure.message)),
            (result) => emit(TvDetailLoaded(result)),
      );
    } on SocketException {
      emit(TvDetailError('connection failed, please try again or update your app!'));
    } catch (err) {
      emit(TvDetailError('something error!'));
    }
  }
}
