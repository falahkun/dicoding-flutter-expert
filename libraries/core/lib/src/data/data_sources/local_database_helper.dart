abstract class LocalDatabaseHelper<T> {
  Future<int> insert(T data);
  Future<int> remove(T data);
  Future<T?> getItemById(int id);
  Future<List<T>> getItems();
}