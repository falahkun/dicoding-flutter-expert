import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_top_rated_event.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  TvTopRatedBloc(this.useCase) : super(TvTopRatedInitial()) {
    on<GetTvTopRatedEvent>(_onGetTvTopRatedEvent);
  }

  final TvUseCase useCase;

  Future<void> _onGetTvTopRatedEvent(
      GetTvTopRatedEvent event, Emitter<TvTopRatedState> emit) async {
    emit(TvTopRatedLoading());
    final result = await useCase.getTopRatedTv();
    result.fold(
      (l) => emit(TvTopRatedError(l.message)),
      (r) => emit(TvTopRatedLoaded(r)),
    );
  }
}
