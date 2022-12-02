import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {

  late MovieRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });


  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
        json.decode(readJson('dummy/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
            () async {
          // arrange
          when(() => mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy/now_playing.json'), 200));
          // act
          final result = await dataSourceImpl.getNowPlayingMovies();
          // assert
          expect(result, equals(tMovieList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getNowPlayingMovies();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
            () async {
          // arrange
          when(() => mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy/popular.json'), 200));
          // act
          final result = await dataSourceImpl.getPopularMovies();
          // assert
          expect(result, tMovieList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getPopularMovies();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
        json.decode(readJson('dummy/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(() => mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy/top_rated.json'), 200));
      // act
      final result = await dataSourceImpl.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(() => mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getTopRatedMovies();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(() => mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy/movie_detail.json'), 200));
      // act
      final result = await dataSourceImpl.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getMovieDetail(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
        json.decode(readJson('dummy/movie_recommendations.json')))
        .movieList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
            () async {
          // arrange
          when(() => mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy/movie_recommendations.json'), 200));
          // act
          final result = await dataSourceImpl.getMovieRecommendations(tId);
          // assert
          expect(result, equals(tMovieList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.getMovieRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
        json.decode(readJson('dummy/search_spiderman_movie.json')))
        .movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(() => mockHttpClient
          .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSourceImpl.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(() => mockHttpClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSourceImpl.searchMovies(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

}