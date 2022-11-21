part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}

class GetTvDetailEvent extends TvDetailEvent {
  final int id;

  GetTvDetailEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
