import 'package:core/core.dart';
import 'package:ditonton/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<NowPlayingBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<PopularBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TvNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<WatchlistTvBloc>(),
        ),
      ],
      child: _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        initialRoute: NamedRoutes.home,
        navigatorObservers: [routeObserver],
        onGenerateRoute: routes);
  }
}
