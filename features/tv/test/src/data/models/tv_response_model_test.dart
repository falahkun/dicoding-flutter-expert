import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';

void main() {
  final tTvModel = TvModel(
    firstAirDate: "2003-10-21",
    name: "Pasión de gavilanes",
    originalLanguage: "es",
    originalName: "Pasión de gavilanes",
    backdropPath: '/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
    popularity: 2262.208,
    posterPath: '/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg',
    voteAverage: 17.7,
    voteCount: 1733,
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy/tv_now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
            "first_air_date": "2003-10-21",
            "genre_ids": [
              1,2,3
            ],
            "id": 1,
            "name": "Pasión de gavilanes",
            "original_language": "es",
            "original_name": "Pasión de gavilanes",
            "overview": "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
            "popularity": 2262.208,
            "poster_path": "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
            "vote_average": 17.7,
            "vote_count": 1733
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
