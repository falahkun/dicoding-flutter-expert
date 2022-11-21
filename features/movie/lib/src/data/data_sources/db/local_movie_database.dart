import 'package:core/core.dart';
import 'package:movie/movie.dart';


class LocalMovieDatabase extends LocalDatabaseHelper<MovieTable> {
  final DatabaseHelper helper;

  LocalMovieDatabase(this.helper);

  @override
  Future<MovieTable?> getItemById(int id) async {
    final db = await helper.database;
    final results = await db!.query(
      tblMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return MovieTable.fromMap(results.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getItems() async {
    final db = await helper.database;
    final List<Map<String, dynamic>> results = await db!.query(tblMovie);

    return List.from(results.map((result) => MovieTable.fromMap(result)));
  }

  @override
  Future<int> insert(MovieTable data) async {
    final db = await helper.database;
    return await db!.insert(tblMovie, data.toJson());
  }

  @override
  Future<int> remove(MovieTable data) async {
    final db = await helper.database;
    return await db!.delete(
      tblMovie,
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

}