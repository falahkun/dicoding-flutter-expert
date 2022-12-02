import 'package:bloc_test/bloc_test.dart';
import 'package:tv/tv.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class MockTvNowPlayingBloc
    extends MockBloc<TvNowPlayingEvent, TvNowPlayingState>
    implements TvNowPlayingBloc {}

class MockTvPopularBloc extends MockBloc<TvPopularEvent, TvPopularState>
    implements TvPopularBloc {}

class MockTvRecommendationBloc
    extends MockBloc<TvRecommendationEvent, TvRecommendationState>
    implements TvRecommendationBloc {}

class MockTvTopRatedBloc extends MockBloc<TvTopRatedEvent, TvTopRatedState>
    implements TvTopRatedBloc {}

class MockTvWatchlistBloc extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvWatchlistBloc {}

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}
