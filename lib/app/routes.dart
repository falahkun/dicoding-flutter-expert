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
    case NamedRoutes.movieDetail:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
        settings: settings,
      );
  //   case SearchPage.ROUTE_NAME:
  //     return CupertinoPageRoute(builder: (_) => SearchPage());
  //   case WatchlistPage.ROUTE_NAME:
  //     return MaterialPageRoute(builder: (_) => WatchlistPage());
  //   case AboutPage.ROUTE_NAME:
  //     return MaterialPageRoute(builder: (_) => AboutPage());
  // //tv
    case NamedRoutes.tvDetail:
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (_) => TvDetailPage(id: id));
    case NamedRoutes.popularTv:
      return MaterialPageRoute(builder: (_) => PopularTvPage());
    case NamedRoutes.topRatedMovie:
      return MaterialPageRoute(builder: (_) => TopRatedTvPage());
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