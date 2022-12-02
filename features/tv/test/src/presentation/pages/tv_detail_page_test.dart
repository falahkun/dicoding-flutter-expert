import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../dummy/tv_objects.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/tv_bloc_mocks.dart';

void main() {
  final int tId = 1;
  late TvWatchlistBloc tvWatchlistBloc;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    tvWatchlistBloc = MockTvWatchlistBloc();
    watchlistTvBloc = MockWatchlistTvBloc();
  });

  group('tv:pages/tv_detail_page', () {
    testWidgets('find add icon when tv watchlist false', (tester) async {
      await tester.pumpApp(TvDetailPage(id: tId));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('find check icon when tv watchlist true', (tester) async {
      when(() => tvWatchlistBloc.state)
          .thenReturn(TvWatchlistState(true));

      await tester.pumpApp(TvDetailPage(id: tId),
          mockTvWatchlistBloc: tvWatchlistBloc);

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('Watchlist when state is Success', (WidgetTester tester) async {


      final watchlistButton = find.byType(ElevatedButton);

      when(() => watchlistTvBloc.state)
          .thenReturn(WatchlistTvInitial());
      when(() =>
          watchlistTvBloc.add(SaveToWatchlistTv(testTvDetail)))
          .thenReturn(WatchlistTvSuccess());

      await tester.pumpApp(
        TvDetailPage(id: tId),
        mockWatchlistTvBloc: watchlistTvBloc,
      );

      await tester.tap(watchlistButton);

      verify(() => watchlistTvBloc.stream).called(2);
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    });

    testWidgets('Watchlist when state is Failed', (WidgetTester tester) async {

      final watchlistButton = find.byType(ElevatedButton);

      when(() => watchlistTvBloc.state)
          .thenReturn(WatchlistTvInitial());
      when(() =>
          watchlistTvBloc.add(SaveToWatchlistTv(testTvDetail)))
          .thenReturn(WatchlistTvError('failed'));

      await tester.pumpApp(
        TvDetailPage(id: tId),
        mockWatchlistTvBloc: watchlistTvBloc,
      );

      await tester.tap(watchlistButton);

      verify(() => watchlistTvBloc.stream).called(2);
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    });
  });
}