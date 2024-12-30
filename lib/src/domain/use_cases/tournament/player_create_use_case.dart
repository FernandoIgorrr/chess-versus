import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:chess_versus/src/data/repositories/tournament/tournament_repository.dart';
import 'package:chess_versus/src/exceptions/player_impossible_name_exception.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../models/player/player.dart';
import '../../models/tournament/tournament.dart';

class PlayerCreateUseCase {
  final PlayerRepository _playerRepository;
  final TournamentRepository _tournamentRepository;
  final _log = Logger('PlayerCreateUseCase');

  PlayerCreateUseCase(
      {required PlayerRepository playerRepository,
      required TournamentRepository tournamentRepository})
      : _playerRepository = playerRepository,
        _tournamentRepository = tournamentRepository;

  AsyncResult<Player, Exception> createFrom(
      String tournamentId, Player player) async {
    if (player.name.toString().isEmpty) {
      throw PlayerImpossibleNameException('Player\'s name is empty');
    } else if (player.name.toString().toLowerCase() == 'bye') {
      throw PlayerImpossibleNameException('the player\'s name cannot be bye');
    }
    try {
      Tournament tournament =
          (await _tournamentRepository.findById(tournamentId)).fold(
        (success) => success,
        (failure) => throw failure,
      );

      var result = await _playerRepository.create(player, tournamentId);

      return Success(player);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
