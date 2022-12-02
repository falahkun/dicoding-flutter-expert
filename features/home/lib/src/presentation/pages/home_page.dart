import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';

class HomePage extends StatefulWidget {
  final int? initialPage;

  const HomePage({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int initialPage = 0;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    AnalyticsHelper.log('HomePage');
    setState(() {
      initialPage = widget.initialPage!;
    });
  }

  @override
  Widget build(BuildContext context) {
    String path = 'assets';
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      path = '../../assets';
    }
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: Column(
          children: [
             UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('$path/circle-g.png'),
              ),
              accountName: const Text('Ditonton'),
              accountEmail: const Text('ditonton@dicoding.com'),
            ),
            ListTile(
              key: Key('tap_movie'),
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () => changeHomeView(0),
            ),
            ListTile(
              key: Key('tap_tv'),
              leading: const Icon(Icons.tv),
              title: const Text('TV'),
              onTap: () => changeHomeView(1),
            ),
            ListTile(
              key: Key('to_watchlist'),
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                context.pushNamed(NamedRoutes.watchlist);
                // Navigator.pushNamed(context, NamedRoutes.watchlist);
              },
            ),
            ListTile(
              key: Key('to_about'),
              onTap: () {
                context.pushNamed(NamedRoutes.about);
                // Navigator.pushNamed(context, NamedRoutes.about);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        leading: IconButton(
            key: Key('leading-icon'),
            onPressed: () {
              _key.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu)),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(NamedRoutes.search);
              // Navigator.pushNamed(context, NamedRoutes.search);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: IndexedStack(
        index: initialPage,
        children: [
          const FragmentMovie(),
          FragmentTv(),
        ],
      ),
    );
  }

  void changeHomeView(int selectedPage) {
    AnalyticsHelper.log(
        'changeHomeView', 'onChange(old: $initialPage, next: $selectedPage)');
    setState(() {
      initialPage = selectedPage;
    });
    Navigator.pop(context);
  }
}
