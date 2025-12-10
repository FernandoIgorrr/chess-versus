import 'package:chess_versus/src/data/repositories/nested_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/player/player.dart';

abstract class PlayerRepository implements NestedRepository<Player, String> {
  /// Creates a new [Player].
  @override
  AsyncResult<void> create(player, tournamentId);

  /// Returns the list of [Players] for the application.
  @override
  AsyncResult<List<Player>> findAll();

  /// Returns the list of [Players] of a determined tournament
  @override
  AsyncResult<List<Player>> findBySuperclassId(tournamentId);

  /// Updates the [Player] with the given [id].
  @override
  Future<Result<void>> update(Player entity, String superclassId);

  @override
  AsyncResult<void> updateAll(List<Player> entityies, String superclassId);

  /// Returns the [Player] with the given [id].
  // Future<Result<void>> delete(String id);
}
