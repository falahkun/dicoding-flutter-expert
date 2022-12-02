import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('test render', () {
    testWidgets('test fragment has appeared or not', (widgetTester) async {
      await widgetTester.pumpApp(HomePage());
      expect(find.byType(IndexedStack), findsOneWidget);
      expect(find.byType(FragmentTv), findsOneWidget);
      expect(find.byType(FragmentMovie), findsOneWidget);
    });

    testWidgets('find drawer', (widgetTester) async {
      await widgetTester.pumpApp(HomePage());
      final leadingIcon = find.byKey(Key('leading-icon'));
      await widgetTester.tap(leadingIcon);
      await widgetTester.pump();
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(4));
    });

    testWidgets('tap drawer', (widgetTester) async {
      await widgetTester.pumpApp(HomePage());
      final leadingIcon = find.byKey(Key('leading-icon'));
      await widgetTester.tap(leadingIcon);
      await widgetTester.pump();
      final tapMovie = find.byKey(Key('tap_movie'));
      final tapTv = find.byKey(Key('tap_tv'));
      final toWatchlist = find.byKey(Key('to_watchlist'));
      await widgetTester.tap(tapMovie);
      await widgetTester.tap(tapTv);
      await widgetTester.tap(toWatchlist);
    });
  });
}