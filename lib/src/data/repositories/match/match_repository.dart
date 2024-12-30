import 'package:chess_versus/src/data/repositories/nested_repository.dart';
import 'package:result_dart/result_dart.dart';
import '../../../domain/models/match/match.dart';

abstract class MatchRepository implements NestedRepository<Match, String> {
  //@override
  // Future<List<String>> getItems();

  //@override
  //Future<bool> setItems(List<String> values);

  @override
  AsyncResult<void, Exception> create(Match match, String superclassId);

  @override
  AsyncResult<List<Match>, Exception> findAll();

  @override
  AsyncResult<Match, Exception> findById(id);

  @override
  AsyncResult<List<Match>, Exception> findBySuperclassId(String superclassId);
}
