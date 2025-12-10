import 'package:chess_versus/src/data/repositories/match/match_repository.dart';
import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:result_dart/result_dart.dart';
import '../../models/match/match.dart';
import '../../models/player/player.dart';

class TournamentMatchResultUpdateUseCase {
  final MatchRepository _matchRepository;
  final PlayerRepository _playerRepository;

  TournamentMatchResultUpdateUseCase({
    required MatchRepository matchRepository,
    required PlayerRepository playerRepository,
  }) : _matchRepository = matchRepository,
       _playerRepository = playerRepository;

  AsyncResult<void> updateMatchFrom(Match match, String roundId) async {
    try {
      await _matchRepository.update(match, roundId);
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<void> updatePlayersScoreFrom(
    List<Player> players,
    String tournamentId,
  ) async {
    try {
      await _playerRepository.updateAll(players, tournamentId);
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
