// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class FragmentMovie extends StatefulWidget {
  const FragmentMovie({Key? key}) : super(key: key);

  @override
  _FragmentMovieState createState() => _FragmentMovieState();
}

class _FragmentMovieState extends State<FragmentMovie> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<NowPlayingBloc>().add(GetMovieNowPlaying());
    context.read<TopRatedBloc>().add(GetTopRatedMovieEvent());
    context.read<PopularBloc>().add(GetPopularMovieEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NamedRoutes.nowPlayingMovie),
              ),
              BlocBuilder<NowPlayingBloc, NowPlayingState>(builder: (_, state) {
                if (state is NowPlayingError) {
                  return const Text('Failed');
                } else if (state is NowPlayingLoaded) {
                  return MovieList(state.list);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, NamedRoutes.popularMovie),
              ),
              BlocBuilder<PopularBloc, PopularState>(builder: (_, state) {
                if (state is PopularError) {
                  return const Text('Failed');
                } else if (state is PopularLoaded) {
                  return MovieList(state.list);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, NamedRoutes.topRatedMovie),
              ),
              BlocBuilder<TopRatedBloc, TopRatedState>(builder: (_, state) {
                if (state is TopRatedError) {
                  return const Text('Failed');
                } else if (state is TopRatedLoaded) {
                  return MovieList(state.list);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NamedRoutes.movieDetail,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
