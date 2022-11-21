part of 'tv_watchlist_bloc.dart';

class TvWatchlistState extends Equatable {
  final bool isExist;

  const TvWatchlistState(this.isExist);

  @override
  // TODO: implement props
  List<Object?> get props => [
        isExist,
      ];
}
