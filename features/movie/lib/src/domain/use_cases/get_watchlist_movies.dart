import 'package:dartz/dartz.dart';

import 'package:movie/movie.dart';
import 'package:core/core.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
