import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late TvRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockHttpClient();
    dataSourceImpl = TvRemoteDataSourceImpl(client: client);
  });
  group('package:tv/src/data_sources/tv_remote_source.dart', () {
    group('getNowPlaying', () {
      test('when success', () async {
        final tTvList = TvResponse.fromJson(
                json.decode(readJson('dummy/tv_now_playing.json')))
            .tvList;
        when(() => client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy/tv_now_playing.json'), 200));

        final act = await dataSourceImpl.getNowPlayingTv();
        expect(act, equals(tTvList));
      });

      test('when error 404 or other', () async {
        when(() => client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
            .thenAnswer((_) async => http.Response('404 error', 404));

        final act = dataSourceImpl.getNowPlayingTv();
        expect(() => act, throwsA(isA<ServerException>()));
      });
    });

    group('getPopular', () {
      test('when success', () async {
        final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy/tv_popular.json')))
            .tvList;
        when(() => client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy/tv_popular.json'), 200));

        final act = await dataSourceImpl.getPopularTv();
        expect(act, equals(tTvList));
      });

      test('when error 404 or other', () async {
        when(() => client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async => http.Response('404 error', 404));

        final act = dataSourceImpl.getPopularTv();
        expect(() => act, throwsA(isA<ServerException>()));
      });
    });

    group('getTopRated', () {
      test('when success', () async {
        final tTvList = TvResponse.fromJson(
                json.decode(readJson('dummy/tv_top_rated.json')))
            .tvList;
        when(() => client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy/tv_top_rated.json'), 200));

        final act = await dataSourceImpl.getTopRatedTv();
        expect(act, equals(tTvList));
      });

      test('when error 404 or other', () async {
        when(() => client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
            .thenAnswer((_) async => http.Response('404 error', 404));

        final act = dataSourceImpl.getTopRatedTv();
        expect(() => act, throwsA(isA<ServerException>()));
      });
    });

    final tvId = 1;
    final tQuery = 'Pasión de gavilanes';

    group('getRecommendations', () {
      test('when success', () async {
        final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy/tv_recommendations.json')))
            .tvList;
        when(() => client.get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY')))
            .thenAnswer((_) async =>
            http.Response(readJson('dummy/tv_recommendations.json'), 200));

        final act = await dataSourceImpl.getTvRecommendations(tvId);
        expect(act, equals(tTvList));
      });

      test('when error 404 or other', () async {
        when(() => client.get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response('404 error', 404));

        final act = dataSourceImpl.getTvRecommendations(tvId);
        expect(() => act, throwsA(isA<ServerException>()));
      });
    });

    group('Search', () {
      test('when success', () async {
        final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy/tv_search_dasada.json')))
            .tvList;
        when(() => client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
            .thenAnswer((_) async =>
            http.Response(readJson('dummy/tv_search_dasada.json'), 200));

        final act = await dataSourceImpl.searchTv(tQuery);
        expect(act, equals(tTvList));
      });

      test('when error 404 or other', () async {
        when(() => client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
            .thenAnswer((_) async => http.Response('404 error', 404));

        final act = dataSourceImpl.searchTv(tQuery);
        expect(() => act, throwsA(isA<ServerException>()));
      });
    });

    group('getTvDetail', () {
      test('when success', () async {
        final tv = TvDetailResponse.fromJson(
                json.decode(readJson('dummy/tv_detail.json')));
        when(() => client.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY')))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy/tv_detail.json'), 200));

        final act = await dataSourceImpl.getTvDetail(tvId);
        expect(act, equals(tv));
      });

      test('when error 404 or other', () async {
        when(() => client.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY')))
            .thenAnswer((_) async => http.Response('404 error', 404));

        final act = dataSourceImpl.getTvDetail(tvId);
        expect(() => act, throwsA(isA<ServerException>()));
      });
    });
  });
}
