import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.tvUseCase,
    required this.searchMovies,
  }) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      emit(SearchLoading());
      final movies = await searchMovies.execute(event.query);
      final tv = await tvUseCase.searchTv(event.query);

      if (movies.isLeft() || tv.isLeft()) {
        emit(SearchError('Not found'));
      } else {
        tv.map((tvResults) {
          movies.map(
            (movieResults) => emit(
              SearchLoaded(
                tvResults: tvResults,
                movieResults: movieResults,
              ),
            ),
          );
        });
      }
    });
  }

  final TvUseCase tvUseCase;
  final SearchMovies searchMovies;
}
