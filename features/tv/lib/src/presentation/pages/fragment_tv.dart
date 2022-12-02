import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class FragmentTv extends StatefulWidget {
  @override
  _FragmentTvState createState() => _FragmentTvState();
}

class _FragmentTvState extends State<FragmentTv> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<TvNowPlayingBloc>().add(GetTvNowPlaying());
    context.read<TvPopularBloc>().add(GetTvPopularEvent());
    context.read<TvTopRatedBloc>().add(GetTvTopRatedEvent());
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
              Text(
                'On The Air',
                style: kHeading6,
              ),
              BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
                builder: (_, state) {
                  if (state is TvNowPlayingError) {
                    return Text('Failed');
                  } else if (state is TvNowPlayingLoaded) {
                    return TvList(state.list);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              _buildSubHeading(
                  title: 'Popular',
                  onTap: () {
                    Navigator.pushNamed(context, NamedRoutes.popularTv);
                  }),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                builder: (_, state) {
                  if (state is TvPopularError) {
                    return Text('Failed');
                  } else if (state is TvPopularLoaded) {
                    return TvList(state.list);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME);
                  }),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                builder: (_, state) {
                  if (state is TvTopRatedError) {
                    return Text('Failed');
                  } else if (state is TvTopRatedLoaded) {
                    return TvList(state.list);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
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
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final _tv = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NamedRoutes.tvDetail,
                  arguments: _tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${_tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
