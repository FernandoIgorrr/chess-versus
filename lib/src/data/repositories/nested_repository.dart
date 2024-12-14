import 'package:result_dart/result_dart.dart';

abstract interface class NestedRepository<E extends Object, I> {
  Future<List<String>> getItems();

  Future<bool> setItems(List<String> values);

  AsyncResult<void, Exception> create(E entity, I superclassId);

  AsyncResult<E, Exception> findById(String id);

  AsyncResult<List<E>, Exception> findAll();

  AsyncResult<List<E>, Exception> findBySuperclassId(I superclassId);
}
