import 'package:core/core.dart';
import 'package:tv/tv.dart';


class TvDatabase extends LocalDatabaseHelper<TvTable> {
  final DatabaseHelper helper;

  TvDatabase(this.helper);

  @override
  Future<TvTable?> getItemById(int id) async {
    final db = await helper.database;
    final results = await db!.query(
      tblTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return TvTable.fromMap(results.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getItems() async {
    final db = await helper.database;
    final List<Map<String, dynamic>> results = await db!.query(tblTv);

    return List.from(results.map((result) => TvTable.fromMap(result)));
  }

  @override
  Future<int> insert(TvTable data) async {
    final db = await helper.database;
    return await db!.insert(tblTv, data.toJson());
  }

  @override
  Future<int> remove(TvTable data) async {
    final db = await helper.database;
    return await db!.delete(
      tblTv,
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

}