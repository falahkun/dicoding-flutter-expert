import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:home/src/presentation/fragment/fragment_list.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSubmitted = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
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

                  context.read<SearchBloc>().add(SearchEvent(query));
                },
                onChanged: (val) {
                  setState(() {
                    isSubmitted = false;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              if (isSubmitted)
                Expanded(
                  child: Column(
                    children: [
                      TabBar(
                          tabs: const [
                            Tab(
                              child: Text("Movies"),
                            ),
                            Tab(
                              child: Text("Tv"),
                            ),
                          ],
                          onTap: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          }),
                      Expanded(child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoaded) {
                            return IndexedStack(
                              index: selectedIndex,
                              children: [
                                FragmentList<Movie>(
                                  list: state.movieResults,
                                  builder: (_, value) => MovieCard(value),
                                ),
                                FragmentList<Tv>(
                                  list: state.tvResults,
                                  builder: (_, value) => TvCard(value),
                                ),
                              ],
                            );
                          } else if (state is SearchLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const SizedBox();
                          }
                        },
                      ))
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
