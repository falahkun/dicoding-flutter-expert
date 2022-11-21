import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'watchlist_tv_event.dart';

part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  WatchlistTvBloc(this.useCase) : super(WatchlistTvInitial()) {
    on<SaveToWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await useCase.saveTvWatchlist(event.tvDetail);
      result.fold(
        (l) => emit(WatchlistTvError(l.message)),
        (r) => emit(WatchlistTvSuccess()),
      );
    });

    on<RemoveFromWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await useCase.removeTvWatchlist(event.tvDetail);
      result.fold(
            (l) => emit(WatchlistTvError(l.message)),
            (r) => emit(WatchlistTvSuccess()),
      );
    });
  }

  final TvUseCase useCase;
}
