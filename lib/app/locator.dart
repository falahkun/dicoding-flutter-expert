import 'dart:io';

import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:home/home.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';

final getIt = GetIt.instance;

Future<void> setUpLocator() async {
  // setUp core
  await _setUpCore();

  // [HOME]

  // Data
  // Domain
  // presentation
  getIt.registerFactory(
    () => SearchBloc(
      tvUseCase: getIt(),
      searchMovies: getIt(),
    ),
  );
  getIt.registerFactory(
    () => WatchlistBloc(
      getWatchlistMovies: getIt(),
      tvUseCase: getIt(),
    ),
  );

  // [Tv]

  // Data
  getIt.registerLazySingleton<TvDatabase>(() => TvDatabase(getIt()));
  getIt.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDatabase: getIt()));

  getIt.registerLazySingleton<TvRepository>(() =>
      TvRepositoryImpl(remoteDataSource: getIt(), localDataSource: getIt()));
  // Domain
  getIt.registerLazySingleton<TvUseCase>(
      () => TvUseCaseImpl(repository: getIt()));

  // Presentation
  getIt.registerFactory(() => TvDetailBloc(getIt()));
  getIt.registerFactory(() => TvNowPlayingBloc(getIt()));
  getIt.registerFactory(() => TvPopularBloc(getIt()));
  getIt.registerFactory(() => TvRecommendationBloc(getIt()));
  getIt.registerFactory(() => TvTopRatedBloc(getIt()));
  getIt.registerFactory(() => TvWatchlistBloc(getIt()));
  getIt.registerFactory(() => WatchlistTvBloc(getIt()));

  // [Movie]

  // Data
  getIt.registerLazySingleton<LocalMovieDatabase>(
      () => LocalMovieDatabase(getIt()));

  getIt.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(localMovieDatabase: getIt()));
  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );
  // Domain
  getIt.registerLazySingleton(() => GetMovieDetail(getIt()));
  getIt.registerLazySingleton(() => GetMovieRecommendations(getIt()));
  getIt.registerLazySingleton(() => GetNowPlayingMovies(getIt()));
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTopRatedMovies(getIt()));
  getIt.registerLazySingleton(() => GetWatchlistMovies(getIt()));
  getIt.registerLazySingleton(() => GetWatchListStatus(getIt()));
  getIt.registerLazySingleton(() => RemoveWatchlist(getIt()));
  getIt.registerLazySingleton(() => SaveWatchlist(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));

  // Presentation
  getIt.registerFactory(() => MovieDetailBloc(getIt()));
  getIt.registerFactory(() => MovieRecommendationBloc(getIt()));
  getIt.registerFactory(() => MovieWatchlistBloc(getIt()));
  getIt.registerFactory(() => NowPlayingBloc(getIt()));
  getIt.registerFactory(() => PopularBloc(getIt()));
  getIt.registerFactory(() => TopRatedBloc(getIt()));
  getIt.registerFactory(
    () => WatchlistMovieBloc(
      saveWatchlist: getIt(),
      removeWatchlist: getIt(),
    ),
  );
}

Future<void> _setUpCore() async {
  getIt.registerFactory<DatabaseHelper>(() => DatabaseHelper());
  HttpClient client = HttpClient(context: await globalContext)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  getIt.registerFactory<http.Client>(() => ioClient);
}
