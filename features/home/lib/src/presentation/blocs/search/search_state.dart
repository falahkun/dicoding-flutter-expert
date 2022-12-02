part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<Tv> tvResults;
  final List<Movie> movieResults;

  SearchLoaded({
    required this.tvResults,
    required this.movieResults,
  });

  @override
  List<Object> get props => [
        tvResults,
        movieResults,
      ];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
