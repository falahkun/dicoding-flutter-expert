import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc({
    required this.getWatchlistMovies,
    required this.tvUseCase,
  }) : super(WatchlistInitial()) {
    on<WatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      final tvResults = await tvUseCase.getWatchlistTv();
      final movieResults = await getWatchlistMovies.execute();

      if (movieResults.isLeft() && tvResults.isLeft()) {
        emit(WatchlistError('Not found'));
      } else {
        tvResults.map((tv) {
          movieResults.map(
                (movie) => emit(
              WatchlistLoaded(
                tvWatchlist: tv,
                movieWatchlist: movie,
              ),
            ),
          );
        });
      }
    });
  }

  final GetWatchlistMovies getWatchlistMovies;
  final TvUseCase tvUseCase;
}
