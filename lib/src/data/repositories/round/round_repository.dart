import 'package:result_dart/result_dart.dart';

import '../../../domain/models/round/round.dart';
import '../nested_repository.dart';

abstract class RoundRepository implements NestedRepository<Round, String> {
  /// Creates a new [Round].
  @override
  AsyncResult<void> create(Round round, String tournamentId);

  /// Returns the list of [Rounds] for the application.
  @override
  AsyncResult<List<Round>> findAll();

  /// Returns the list of [Rounds] of a determined tournament
  @override
  AsyncResult<List<Round>> findBySuperclassId(String tournamentId);

  /// Updates the [Round] with the given [id].
  @override
  Future<Result<void>> update(Round round, String tournamentId);

  /// Upadtes the list of [Rounds].
  @override
  Future<Result<void>> updateAll(List<Round> rounds, String tournamentId);

  /// Returns the [Round] with the given [id].
  Future<Result<void>> delete(String id);
}
