import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    firstAirDate: "2003-10-21",
    name: "Pasión de gavilanes",
    originalLanguage: "en",
    originalName:"Pasión de gavilanes",
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTv = Tv(
    firstAirDate: "2003-10-21",
    name: "Pasión de gavilanes",
    originalLanguage: "en",
    originalName:"Pasión de gavilanes",
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );



  test('should be a subclass of Movie entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
