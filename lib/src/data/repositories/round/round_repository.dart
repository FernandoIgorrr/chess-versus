import 'package:chess_versus/src/data/exceptions/round_create_exception.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/round/round.dart';
import '../../exceptions/rounds_fetch_expetion.dart';
import '../nested_repository.dart';

abstract class RoundRepository implements NestedRepository<Round, String> {
  /// Creates a new [Round].
  @override
  AsyncResult<void, RoundCreateException> create(
      Round round, String tournamentId);

  /// Returns the list of [Rounds] for the application.
  @override
  AsyncResult<List<Round>, RoundsFetchException> findAll();

  /// Returns the list of [Rounds] of a determined tournament
  @override
  AsyncResult<List<Round>, Exception> findBySuperclassId(String tournamentId);

  /// Updates the [Round] with the given [id].
  // Future<Result<void>> update(Tournament tournament);

  /// Returns the [Round] with the given [id].
  // Future<Result<void>> delete(String id);
}
