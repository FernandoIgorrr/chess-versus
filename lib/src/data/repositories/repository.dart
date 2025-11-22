import 'package:result_dart/result_dart.dart';

abstract interface class Repository<T extends Object> {
  Future<List<String>> getItems();

  Future<bool> setItems(List<String> values);

  AsyncResult<void> create(T e);

  AsyncResult<T> findById(String id);

  AsyncResult<List<T>> findAll();

  AsyncResult<void> update(T e);

  AsyncResult<void> updateAll(List<T> e);
}
