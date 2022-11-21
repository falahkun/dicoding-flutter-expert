import 'package:ditonton/presentation/pages/fragment_watchlist_movies.dart';
import 'package:ditonton/presentation/pages/fragment_watchlist_tv.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>  {

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
          ]),
        ),
        body: TabBarView(children: [
          FragmentWatchlistMovies(),
          FragmentWatchlistTv()
        ]),
      ),
    );
  }
}
