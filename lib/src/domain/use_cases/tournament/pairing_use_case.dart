import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:chess_versus/src/exceptions/tournament_assembly_exception.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/match/match_repository.dart';
import '../../../data/repositories/round/round_repository.dart';
import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../models/player/player.dart';
import '../../models/tournament/tournament.dart';

class PairingUseCase {
  final TournamentRepository _tournamentRepository;
  final PlayerRepository _playerRepository;
  final MatchRepository _matchRepository;
  final RoundRepository _roundRepository;

  final _log = Logger('RoundCreateUseCase');

  PairingUseCase({
    required TournamentRepository tournamentRepository,
    required PlayerRepository playerRepository,
    required RoundRepository roundRepository,
    required MatchRepository matchRepository,
  })  : _tournamentRepository = tournamentRepository,
        _playerRepository = playerRepository,
        _roundRepository = roundRepository,
        _matchRepository = matchRepository;

  /*AsyncResult<void, Exception> pairingFrom(
      Tournament tournament) async {
    try {
      (await _tournamentRepository.findById(tournament.id)).fold(
        (success) => success,
        (failure) => throw failure,
      );

      (await _roundRepository.create(round, tournament.id)).fold((onSuccess) {},
          (onFailure) {
        throw onFailure;
      });

      return Success(round);
    } on Exception catch (e) {
      return Failure(e);
    }
  }*/

  AsyncResult<Tournament, Exception> assemblyTournament(
      String tournamentId) async {
    try {
      var tournament =
          await _tournamentRepository.findById(tournamentId).getOrThrow();
      tournament.setPlayers(
          (await _playerRepository.findBySuperclassId(tournamentId))
              .getOrThrow());
      var rounds =
          await _roundRepository.findBySuperclassId(tournamentId).getOrThrow();
      rounds.forEach((r) async => r.setMatches(
          (await _matchRepository.findBySuperclassId(r.id)).getOrThrow()));
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

    //for()
  }

  Map<String, Player> _mapCompetitorsById(List<Player> players) {
    return {for (var player in players) player.id: player};
  }
}
