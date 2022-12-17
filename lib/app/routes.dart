import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoutes.home:
      return MaterialPageRoute(builder: (_) => HomePage());
    case NamedRoutes.popularMovie:
      return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
    case NamedRoutes.topRatedMovie:
      return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
      case NamedRoutes.nowPlayingMovie:
      return CupertinoPageRoute(builder: (_) => NowPlayingMoviePage());
    case NamedRoutes.movieDetail:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
        settings: settings,
      );
    case NamedRoutes.search:
      return CupertinoPageRoute(builder: (_) => SearchPage());
    case NamedRoutes.watchlist:
      return MaterialPageRoute(builder: (_) => WatchlistPage());
    case NamedRoutes.about:
      return MaterialPageRoute(builder: (_) => AboutPage());
  //tv
    case NamedRoutes.tvDetail:
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (_) => TvDetailPage(id: id));
    case NamedRoutes.popularTv:
      return MaterialPageRoute(builder: (_) => PopularTvPage());
    case NamedRoutes.topRatedTv:
      return MaterialPageRoute(builder: (_) => TopRatedTvPage());
    case NamedRoutes.tvOnAir:
      return MaterialPageRoute(builder: (_) => NowPlayingTvPage());
    default:
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
          body: Center(
            child: Text('Page not found :('),
          ),
        );
      });
  }
}