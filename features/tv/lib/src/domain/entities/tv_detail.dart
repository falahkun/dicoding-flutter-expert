// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

   bool? adult;
   String? backdropPath;
   List<int>? episodeRunTime;
   String? firstAirDate;
   List<Genre>? genres;
   String? homepage;
   int? id;
   bool? inProduction;
   List<String>? languages;
   String? lastAirDate;
   String? name;
   int? numberOfEpisodes;
   int? numberOfSeasons;
   String? originalLanguage;
   String? originalName;
   String? overview;
   double? popularity;
   String? posterPath;
   String? status;
   String? tagline;
   String? type;
   double? voteAverage;
   int? voteCount;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    languages,
    lastAirDate,
    name,
    numberOfEpisodes,
    numberOfSeasons,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];
}
