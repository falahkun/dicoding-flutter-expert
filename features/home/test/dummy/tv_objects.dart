
import 'package:tv/tv.dart';
import 'package:core/core.dart';

final testTv = Tv(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: "originalName",
  overview: 'overview',
  posterPath: 'posterPath',
  originalLanguage: "en",
  name: "name",
  firstAirDate: "2022-03-13",
  episodeRunTime: [
    10,10
  ],
  voteAverage: 1,
  voteCount: 1,
  status: "status",
  homepage: "homepage",
  inProduction: true,
  languages: ["en"],
  lastAirDate: "lastAirDate",
  numberOfEpisodes: 51,
  numberOfSeasons: 3,
  popularity: 1,
  tagline: "tagline",
  type: "type"
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
