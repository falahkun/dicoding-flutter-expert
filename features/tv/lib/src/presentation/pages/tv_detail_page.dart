import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tv';

  final int id;

  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvWatchlistBloc>().add(TvWatchlistEvent(widget.id));
    context.read<TvDetailBloc>().add(GetTvDetailEvent(widget.id));
    context
        .read<TvRecommendationBloc>()
        .add(GetTvRecommendationEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlist =
    context.select((TvWatchlistBloc bloc) => bloc.state);
    return Scaffold(
      body: BlocListener<WatchlistTvBloc, WatchlistTvState>(
        listener: (context, state) {
          if (state is WatchlistTvSuccess) {
            context.read<TvWatchlistBloc>().add(TvWatchlistEvent(widget.id));
            if (isAddedToWatchlist.isExist) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('success, item removed from watchlist')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('success, item added to watchlist')));
            }
          } else if (state is WatchlistTvError){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailError) {
              return Center(child: Text(state.message));
            } else if (state is TvDetailLoaded) {
              final tv = state.tvDetail;
              return SafeArea(
                child: DetailContent(
                  tv,
                ),
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

class DetailContent extends StatelessWidget {
  final TvDetail tv;

  DetailContent(this.tv);

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlist =
        context.select((TvWatchlistBloc bloc) => bloc.state);
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name ?? '-',
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedToWatchlist.isExist) {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(SaveToWatchlistTv(tv));
                                } else {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(RemoveFromWatchlistTv(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedToWatchlist.isExist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres!),
                            ),
                            Text(
                              _showDuration(tv.episodeRunTime!),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview!,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationBloc,
                                TvRecommendationState>(
                              builder: (_, state) {
                                if (state is TvRecommendationError) {
                                  return Text(state.message);
                                } else if (state is TvRecommendationLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.list[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.list.length,
                                    ),
                                  );
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(List<int> runtime) {
    String time = runtime.join('.');

    return "$time minutes";
  }
}
