import 'package:result_dart/result_dart.dart';

abstract interface class NestedRepository<E extends Object, I> {
  Future<List<String>> getItems();

  Future<bool> setItems(List<String> values);

  AsyncResult<void> create(E entity, I superclassId);

  AsyncResult<E> findById(String id);

  AsyncResult<List<E>> findAll();

  AsyncResult<List<E>> findBySuperclassId(I superclassId);

  AsyncResult<void> update(E entity, I superclassId);

  AsyncResult<void> updateAll(List<E> entities, I superclassId);
}
