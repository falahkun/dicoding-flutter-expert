part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  final String query;

  const SearchEvent(this.query);

  @override
  // TODO: implement props
  List<Object?> get props => [
        query,
      ];
}
