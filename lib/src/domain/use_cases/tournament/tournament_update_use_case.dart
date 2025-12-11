import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/match/match_repository.dart';
import '../../../data/repositories/player/player_repository.dart';
import '../../../data/repositories/round/round_repository.dart';
import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../models/tournament/tournament.dart';

class TournamentUpdateUseCase {
  final TournamentRepository _tournamentRepository;
  final PlayerRepository _playerRepository;
  final MatchRepository _matchRepository;
  final RoundRepository _roundRepository;

  //final _log = Logger('TournamentUpdateUseCase');

  TournamentUpdateUseCase({
    required TournamentRepository tournamentRepository,
    required PlayerRepository playerRepository,
    required RoundRepository roundRepository,
    required MatchRepository matchRepository,
  }) : _tournamentRepository = tournamentRepository,
       _playerRepository = playerRepository,
       _roundRepository = roundRepository,
       _matchRepository = matchRepository;

  AsyncResult<void> updateFrom(Tournament tournament) async {
    //_log.fine('updateFrom');

    try {
      await _tournamentRepository.update(tournament);
      await _roundRepository.updateAll(tournament.rounds, tournament.id);
      await _playerRepository.updateAll(tournament.players, tournament.id);

      for (var round in tournament.rounds) {
        (await _matchRepository.updateAll(
          round.matches,
          round.id,
        )).getOrThrow();
      }

      /*tournament.rounds.forEach(
        (round) async =>
            await _matchRepository.updateAll(round.matches, round.id),
      );*/
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
