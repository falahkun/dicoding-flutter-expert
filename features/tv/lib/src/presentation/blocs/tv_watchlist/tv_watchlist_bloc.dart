import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_watchlist_event.dart';

part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  TvWatchlistBloc(this.useCase) : super(TvWatchlistState(false)) {
    on<TvWatchlistEvent>((event, emit) async {
      final result = await useCase.isAddedToWatchlist(event.id);
      emit(TvWatchlistState(result));
    });
  }

  final TvUseCase useCase;
}
