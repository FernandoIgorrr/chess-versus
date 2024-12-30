import 'package:chess_versus/src/data/repositories/nested_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/player/player.dart';
import '../../../exceptions/player_fetch_exception.dart';

abstract class PlayerRepository implements NestedRepository<Player, String> {
  /// Creates a new [Player].
  @override
  AsyncResult<void, Exception> create(player, tournamentId);

  /// Returns the list of [Players] for the application.
  @override
  AsyncResult<List<Player>, PlayerFetchException> findAll();

  /// Returns the list of [Players] of a determined tournament
  @override
  AsyncResult<List<Player>, Exception> findBySuperclassId(tournamentId);

  /// Updates the [Player] with the given [id].
  // Future<Result<void>> update(Tournament tournament);

  /// Returns the [Player] with the given [id].
  // Future<Result<void>> delete(String id);
}
