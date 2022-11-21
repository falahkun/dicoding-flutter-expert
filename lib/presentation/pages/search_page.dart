import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSubmitted = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  setState(() {
                    isSubmitted = true;
                  });
                  Provider.of<MovieSearchNotifier>(context, listen: false)
                      .fetchMovieSearch(query);
                  Provider.of<TvSearchNotifier>(context, listen: false)
                      .fetchTvSearch(query);
                },
                onChanged: (val) {
                  setState(() {
                    isSubmitted = false;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),

              if (isSubmitted)
              Expanded(
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(child: Text("Movies"),),
                      Tab(child: Text("Tv"),),
                    ]),
                    Expanded(child: TabBarView(children: [
                      Consumer<MovieSearchNotifier>(
                        builder: (context, data, child) {
                          if (data.state == RequestState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.state == RequestState.Loaded) {
                            final result = data.searchResult;
                            return ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final movie = data.searchResult[index];
                                return MovieCard(movie);
                              },
                              itemCount: result.length,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      Consumer<TvSearchNotifier>(
                        builder: (context, data, child) {
                          if (data.state == RequestState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.state == RequestState.Loaded) {
                            final result = data.searchResult;
                            return ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final tv = data.searchResult[index];
                                return TvCard(tv);
                              },
                              itemCount: result.length,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ]))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
