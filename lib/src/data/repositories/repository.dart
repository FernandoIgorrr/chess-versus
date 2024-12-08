import 'package:result_dart/result_dart.dart';

abstract interface class Repository<T> {
  Future<String?> getItems();

  Future<void> setItems(String value);

  Future<void> create(T t);

  AsyncResult<List<T>, Exception> findAll();
}
