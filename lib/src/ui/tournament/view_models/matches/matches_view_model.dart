import 'package:chess_versus/src/domain/use_cases/tournament/tournament_match_result_update_use_case.dart';

import '../../../../domain/models/match/match.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/player/player.dart';
import 'match_state_tap.dart';

class MatchesViewModel extends ChangeNotifier {
  final TournamentMatchResultUpdateUseCase _tournamentMatchResultUpdateUseCase;

  MatchesViewModel({
    required TournamentMatchResultUpdateUseCase
    tournamentMatchResultUpdateUseCase,
  }) : _tournamentMatchResultUpdateUseCase = tournamentMatchResultUpdateUseCase;

  MatchTapState _stateTap = MatchNotTapped();

  MatchTapState get stateTap => _stateTap;

  void emitNoMatchTapped() {
    _stateTap = MatchNotTapped();
    notifyListeners();
  }

  void emitMatchTapped(Match match) {
    _stateTap = MatchTapped(match);
    notifyListeners();
  }

  void emitByeMatchTapped() {
    _stateTap = MatchNotTapped();
    notifyListeners();
  }

  Future<void> updateMatch(Match match, String roundId) async {
    await _tournamentMatchResultUpdateUseCase.updateMatchFrom(match, roundId);
  }

  Future<void> updatePlayersScore(
    List<Player> players,
    String tournamentId,
  ) async {
    await _tournamentMatchResultUpdateUseCase.updatePlayersScoreFrom(
      players,
      tournamentId,
    );
  }
}
