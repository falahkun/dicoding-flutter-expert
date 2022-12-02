
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockNowPlayingBloc extends MockBloc<NowPlayingEvent, NowPlayingState>
    implements NowPlayingBloc {}

class MockPopularBloc extends MockBloc<PopularEvent, PopularState>
    implements PopularBloc {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MockTopRatedBloc extends MockBloc<TopRatedEvent, TopRatedState>
    implements TopRatedBloc {}

class MockMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}