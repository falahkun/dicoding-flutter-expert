import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_popular_event.dart';

part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  TvPopularBloc(this.useCase) : super(TvPopularInitial()) {
    on<GetTvPopularEvent>(_onGetTvPopularEvent);
  }

  final TvUseCase useCase;

  Future<void> _onGetTvPopularEvent(
      GetTvPopularEvent event, Emitter<TvPopularState> emit) async {
    emit(TvPopularLoading());
    final result = await useCase.getPopularTv();
    result.fold(
      (failure) => emit(TvPopularError(failure.message)),
      (result) => emit(TvPopularLoaded(result)),
    );
  }
}
