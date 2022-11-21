
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({Key? key}) : super(key: key);


  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedBloc>().add(GetTopRatedMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedBloc, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is TopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.list[index];
                  return MovieCard(movie);
                },
                itemCount: state.list.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );

            }
          },
        ),
      ),
    );
  }
}
