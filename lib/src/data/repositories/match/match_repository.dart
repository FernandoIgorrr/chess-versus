import 'package:chess_versus/src/data/repositories/nested_repository.dart';
import 'package:result_dart/result_dart.dart';
import '../../../domain/models/match/match.dart';

abstract class MatchRepository implements NestedRepository<Match, String> {
  //@override
  // Future<List<String>> getItems();

  //@override
  //Future<bool> setItems(List<String> values);

  @override
  AsyncResult<void> create(Match match, String superclassId);

  @override
  AsyncResult<List<Match>> findAll();

  @override
  AsyncResult<Match> findById(id);

  @override
  AsyncResult<List<Match>> findBySuperclassId(String superclassId);

  @override
  AsyncResult<void> update(Match entity, String superclassId);

  @override
  AsyncResult<void> updateAll(List<Match> entity, String superclassId);
}
