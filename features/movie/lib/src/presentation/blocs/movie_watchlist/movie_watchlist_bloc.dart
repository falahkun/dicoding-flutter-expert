// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';


part 'movie_watchlist_event.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  MovieWatchlistBloc(this.getWatchListStatus)
      : super(MovieWatchlistState(false)) {
    on<MovieWatchlistEvent>(_onMovieWatchlistEvent);
  }

  final GetWatchListStatus getWatchListStatus;

  Future<void> _onMovieWatchlistEvent(
      MovieWatchlistEvent event, Emitter<MovieWatchlistState> emit) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(MovieWatchlistState(result));
  }
}
