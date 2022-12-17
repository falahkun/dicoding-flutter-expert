
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class NowPlayingMoviePage extends StatefulWidget {

  @override
  _NowPlayingMoviePageState createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingBloc>().add(GetMovieNowPlaying());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is NowPlayingLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.list[index];
                  return MovieCard(movie);
                },
                itemCount: state.list.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
