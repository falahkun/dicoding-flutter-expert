import 'dart:async';

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
    final result = await useCase.getTvDetail(event.id);
    result.fold(
      (failure) => emit(TvDetailError(failure.message)),
      (result) => emit(TvDetailLoaded(result)),
    );
  }
}
