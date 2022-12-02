
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../../dummy/movie_object.dart';
import '../../../helpers/movie_bloc_mocks.dart';
import '../../../helpers/pump_app.dart';

void main() {
  final int tId = 1;
  group('movie:pages/movie_detail_page', () {
    testWidgets('find add icon when movie watchlist false', (tester) async {
      await tester.pumpApp(MovieDetailPage(id: tId));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('find check icon when movie watchlist true', (tester) async {
      final mockMovieWatchlistBloc = MockMovieWatchlistBloc();

      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistState(true));

      await tester.pumpApp(MovieDetailPage(id: tId),
          mockMovieWatchlistBloc: mockMovieWatchlistBloc);

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('Watchlist when state is Success', (WidgetTester tester) async {
      final mockWatchlistMovieBloc = MockWatchlistMovieBloc();

      final watchlistButton = find.byType(ElevatedButton);

      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(WatchlistMovieInitial());
      when(() =>
              mockWatchlistMovieBloc.add(SaveMovieToWatchlist(testMovieDetail)))
          .thenReturn(WatchlistMovieSuccess());

      await tester.pumpApp(
        MovieDetailPage(id: tId),
        mockWatchlistMovieBloc: mockWatchlistMovieBloc,
      );

      await tester.tap(watchlistButton);

      verify(() => mockWatchlistMovieBloc.stream).called(2);
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    });

    testWidgets('Watchlist when state is Failed', (WidgetTester tester) async {
      final mockWatchlistMovieBloc = MockWatchlistMovieBloc();

      final watchlistButton = find.byType(ElevatedButton);

      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(WatchlistMovieInitial());
      when(() =>
          mockWatchlistMovieBloc.add(SaveMovieToWatchlist(testMovieDetail)))
          .thenReturn(WatchlistMovieError('failed'));

      await tester.pumpApp(
        MovieDetailPage(id: tId),
        mockWatchlistMovieBloc: mockWatchlistMovieBloc,
      );

      await tester.tap(watchlistButton);

      verify(() => mockWatchlistMovieBloc.stream).called(2);
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    });
  });
}
