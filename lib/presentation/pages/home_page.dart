import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/fragment_movie.dart';
import 'package:ditonton/presentation/pages/fragment_tv.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int? initialPage;

  const HomePage({Key? key, this.initialPage = 0}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int initialPage = 0;
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      initialPage = widget.initialPage!;
      _controller = PageController(initialPage: initialPage);
    });
    Future.microtask(
            () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
    Future.microtask(
            () => Provider.of<TvListNotifier>(context, listen: false)
          ..fetchNowPlayingTv()
          ..fetchPopularTv()
          ..fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () => changeHomeView(0),
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV'),
              onTap: () => changeHomeView(1),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int newPage) {
          setState(() {
            initialPage = newPage;
          });
        },
        children: [
          FragmentMovie(),
          FragmentTv()
        ],
      ),
    );
  }

  void changeHomeView(int selectedPage) {
    setState(() {
      _controller!.jumpToPage(selectedPage);
    });
  }
}
