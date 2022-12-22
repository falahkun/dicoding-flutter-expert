// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';


part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  WatchlistMovieBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistMovieInitial()) {
    on<RemoveMovieFromWatchlist>(_onRemoveMovieFromWatchlist);
    on<SaveMovieToWatchlist>(_onSaveMovieToWatchlist);
  }

  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  Future<void> _onSaveMovieToWatchlist(
      SaveMovieToWatchlist event, Emitter<WatchlistMovieState> emit) async {
    emit(WatchlistMovieLoading());
    final result = await saveWatchlist.execute(event.movie);
    result.fold(
      (failure) => emit(WatchlistMovieError(failure.message)),
      (result) => emit(WatchlistMovieSuccess()),
    );
  }

  Future<void> _onRemoveMovieFromWatchlist(
      RemoveMovieFromWatchlist event, Emitter<WatchlistMovieState> emit) async {
    emit(WatchlistMovieLoading());
    final result = await removeWatchlist.execute(event.movie);
    result.fold(
      (failure) => emit(WatchlistMovieError(failure.message)),
      (result) => emit(WatchlistMovieSuccess()),
    );
  }
}
