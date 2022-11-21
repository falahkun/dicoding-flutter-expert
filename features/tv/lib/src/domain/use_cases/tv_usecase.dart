// ignore_for_file: depend_on_referenced_packages

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

abstract class TvUseCase {
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tvDetail);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tvDetail);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}


class TvUseCaseImpl extends TvUseCase {
  final TvRepository repository;

  TvUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTv() async => await repository.getNowPlayingTv();

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async => await repository.getPopularTv();

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async => await repository.getTopRatedTv();

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async => await repository.getTvDetail(id);

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async => await repository.getTvRecommendations(id);

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async => await repository.getWatchlistTv();

  @override
  Future<bool> isAddedToWatchlist(int id) async => await repository.isAddedToWatchlist(id);

  @override
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tvDetail) async => await repository.removeTvWatchlist(tvDetail);

  @override
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tvDetail) async => await repository.saveTvWatchlist(tvDetail);

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async => await repository.searchTv(query);
}
