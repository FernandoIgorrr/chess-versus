import 'package:result_dart/result_dart.dart';

import '../../../domain/models/player/player.dart';
import '../../../domain/models/player/player_raw_dto.dart';
import '../repository.dart';

abstract class PlayerRawDtoRepository implements Repository<PlayerRawDto> {
  /// Creates a new [Player].
  @override
  AsyncResult<void> create(PlayerRawDto playerRawDto);

  /// Returns the list of [Players] for the application.
  @override
  AsyncResult<List<PlayerRawDto>> findAll();

  /// Returns the list of [Players] of a determined tournament
  AsyncResult<List<PlayerRawDto>> findByTournament(String tournamentId);

  /// Updates the [Player] with the given [id].
  @override
  Future<Result<void>> update(PlayerRawDto playerRawDto);

  /// Updates the a list of [Player] with the given list.
  @override
  AsyncResult<void> updateAll(List<PlayerRawDto> playersRawDto);

  /// Delete the [Player] with the given [id].
  // Future<Result<void>> delete(String id);
}
