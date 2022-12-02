import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

import '../fragment/fragment_list.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(WatchlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(tabs: [
            Tab(child: Text("Movies"),),
            Tab(child: Text("Tv"),),
          ], onTap: (value) => setState(() => selectedIndex = value)),
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    FragmentList<Movie>(
                      builder: (_, value) => MovieCard(value),
                      list: state.movieWatchlist,
                    ),
                    FragmentList<Tv>(
                      builder: (_, value) => TvCard(value),
                      list: state.tvWatchlist,
                    ),
                  ],
                ),
              );
            } else if (state is WatchlistLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SizedBox();
            }

          },
        ),
      ),
    );
  }
}
