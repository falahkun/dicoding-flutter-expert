import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../dummy/tv_objects.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}
class MockTvDatabase extends Mock implements TvDatabase {}

void main() {
  late TvDatabase tvDatabase;
  late TvLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    tvDatabase = MockTvDatabase();
    dataSourceImpl = TvLocalDataSourceImpl(tvDatabase: tvDatabase);
  });

  group('package:tv/src/data_sources/tv_local_data_source.dart', () {
    group('save watchlist', () {
      test('when success', () async {
        when(()  => tvDatabase.insert(testTvTable)).thenAnswer((_) async => 1);

        final act = await dataSourceImpl.insertWatchlist(testTvTable);
        expect(act, 'Added to Watchlist');
      });

      test('when error', () async {
        when(()  => tvDatabase.insert(testTvTable))
            .thenThrow(Exception());

        final act = dataSourceImpl.insertWatchlist(testTvTable);
        expect(() => act, throwsA(isA<DatabaseException>()));
      });
    });
  });
}
