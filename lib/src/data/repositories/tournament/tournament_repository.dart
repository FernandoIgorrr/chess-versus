import 'package:chess_versus/src/data/repositories/repository.dart';
import 'package:chess_versus/src/domain/models/tournament/tournament.dart';
import 'package:chess_versus/src/exceptions/tournament_fetch_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class TournamentRepository implements Repository<Tournament> {
  /// Creates a new [Tournament].
  @override
  AsyncResult<void, Exception> create(Tournament tournament);

  /// Returns the list of [Tournament] for the application.
  @override
  AsyncResult<List<Tournament>, TournamentFetchExcpetion> findAll();

  /// Returns the [Tournament] with the given [id].
  //Future<Result<Tournament>> fetchById(String id);

  /// Updates the [Tournament] with the given [id].
  // Future<Result<void>> update(Tournament tournament);

  /// Returns the [Tournament] with the given [id].
  // Future<Result<void>> delete(String id);
}
