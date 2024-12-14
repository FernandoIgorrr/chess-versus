import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../models/player/player.dart';
import '../../models/tournament/tournament.dart';

class TournamentLoadUseCase {
  final TournamentRepository _tournamentRepository;
  final PlayerRepository _playerRepository;

  final _log = Logger('TournamentLoadUseCase');

  TournamentLoadUseCase({
    required TournamentRepository tournamentRepository,
    required PlayerRepository playerRepository,
  })  : _tournamentRepository = tournamentRepository,
        _playerRepository = playerRepository;

  AsyncResult<Tournament, Exception> loadFrom(String id) async {
    _log.fine('loadFrom');

    try {
      Tournament tournament = (await _tournamentRepository.findById(id)).fold(
        (success) => success,
        (failure) => throw failure,
      );

      List<Player> players =
          (await _playerRepository.findBySuperclassId(id)).fold(
        (success) => success,
        (failure) => throw failure,
      );

      tournament.setPlayers(players);

      return Success(tournament);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
