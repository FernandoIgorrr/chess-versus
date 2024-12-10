import 'package:result_dart/result_dart.dart';

abstract interface class Repository<T> {
  Future<List<String>?> getItems();

  Future<bool> setItems(List<String> values);

  AsyncResult<void, Exception> create(T t);

  AsyncResult<List<T>, Exception> findAll();
}
