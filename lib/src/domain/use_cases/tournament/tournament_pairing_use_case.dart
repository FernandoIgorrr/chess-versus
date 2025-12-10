import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:chess_versus/src/data/exceptions/tournament_assembly_exception.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_update_use_case.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/match/match_repository.dart';
import '../../../data/repositories/round/round_repository.dart';
import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../models/player/player.dart';
import '../../models/tournament/tournament.dart';

class TournamentPairingUseCase {
  final TournamentRepository _tournamentRepository;
  final PlayerRepository _playerRepository;
  final MatchRepository _matchRepository;
  final RoundRepository _roundRepository;

  final _log = Logger('TournamentPairingUseCase');

  TournamentPairingUseCase({
    required TournamentRepository tournamentRepository,
    required PlayerRepository playerRepository,
    required RoundRepository roundRepository,
    required MatchRepository matchRepository,
    required TournamentUpdateUseCase tournamentUpdateUseCase,
  }) : _tournamentRepository = tournamentRepository,
       _playerRepository = playerRepository,
       _roundRepository = roundRepository,
       _matchRepository = matchRepository;

  void pairingFrom(Tournament tournament) {
    //_log.fine(tournament.toString());

    if (tournament.rounds.isEmpty) {
      tournament.initiateTournament();
      //_log.fine("BYE PLAYER  :  ${tournament.rounds.first.notPaired!.name}}");
    } else {
      _log.fine(' ******* swiss pairing irá acontecer aqui!');
      _log.fine(tournament.rounds.length.toString());
      tournament.swissPairing();
    }

    //_log.fine(tournament.rounds.first.matches.first.toString());
  }

  AsyncResult<Tournament> assemblyTournament(String tournamentId) async {
    try {
      var tournament = await _tournamentRepository
          .findById(tournamentId)
          .getOrThrow();
      tournament.setPlayers(
        (await _playerRepository.findBySuperclassId(tournamentId)).getOrThrow(),
      );
      var rounds = await _roundRepository
          .findBySuperclassId(tournamentId)
          .getOrThrow();
      rounds.forEach(
        (r) async => r.setMatches(
          (await _matchRepository.findBySuperclassId(r.id)).getOrThrow(),
        ),
      );
      tournament.setRounds(rounds);
      resolvePlayerReferences(tournament);
      return Success(tournament);
    } catch (e) {
      return Failure(TournamentAssemblyException(e.toString()));
    }
  }

  void resolvePlayerReferences(Tournament tournament) {
    final playerById = _mapCompetitorsById(tournament.players);
    // final desqualifiedPlayersById = _mapCompetitorsById(desqualifiedPlayers);
    for (var round in tournament.rounds) {
      // if (haveBye) {
      round.notPaired = playerById[round.notPaired!.id] ?? round.notPaired;
      // }
      for (var game in round.matches) {
        game.setWhite = playerById[game.white.id] ?? game.white;
        game.setBlack = playerById[game.black.id] ?? game.black;
      }
    }
  }

  Map<String, Player> _mapCompetitorsById(List<Player> players) {
    return {for (var player in players) player.id: player};
  }
}
