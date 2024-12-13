import 'package:result_dart/result_dart.dart';

import '../../../domain/models/player/player.dart';
import '../repository.dart';

abstract class PlayerRepository implements Repository<Player> {
  /// Creates a new [Player].
  @override
  AsyncResult<void, Exception> create(Player player);

  /// Returns the list of [Players] for the application.
  ///@override
  ///AsyncResult<List<Player>, PlayerFetchException> findAll();

  /// Returns the [Player] with the given [tournamentId].
  //Future<Result<Player>> fetchById(String id);

  /// Returns the list of [Players] of a determined tournament
  AsyncResult<List<Player>, Exception> fetchByTournamentId(String tournamentId);

  /// Updates the [Player] with the given [id].
  // Future<Result<void>> update(Tournament tournament);

  /// Returns the [Player] with the given [id].
  // Future<Result<void>> delete(String id);
}
