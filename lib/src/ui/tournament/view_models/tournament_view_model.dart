import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/match/match_repository.dart';
import '../../../data/repositories/player/player_repository.dart';
import '../../../data/repositories/round/round_repository.dart';
import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../../domain/models/tournament/tournament.dart';
import 'tournament_get_state.dart';
import 'tournament_state.dart';

class TournamentViewModel extends ChangeNotifier {
  final TournamentRepository _tournamentRepository;
  final PlayerRepository _playerRepository;
  final RoundRepository _roundRepository;
  final MatchRepository _matchRepository;

  TournamentState _state = IdleTournamentState();
  TournamentGetState _stateGet = IdleTournamentGetState();

  final _log = Logger('TourmanetViewModel');

  TournamentViewModel(
      {required TournamentRepository tournamentRepository,
      required PlayerRepository playerRepository,
      required RoundRepository roundRepository,
      required MatchRepository matchRepository})
      : _tournamentRepository = tournamentRepository,
        _playerRepository = playerRepository,
        _roundRepository = roundRepository,
        _matchRepository = matchRepository;

  TournamentGetState get stateGet => _stateGet;

  emit(TournamentGetState state) {
    _stateGet = state;
    //  _log.fine('Notifying listeners: $state');
    if (state is FailureTournamentGetState) {
      // _log.warning('erro: ${state.message}');
    }
    notifyListeners();
  }

  Future<void> getTournament(String id) async {
    _log.fine('getTournament');
    await (await _tournamentRepository.findById(id))
        .map(SuccessTournamentGetState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureTournamentGetState.new)
        .fold(emit, emit);

    assemblyTournament(id);
  }

  assemblyTournament(String id) async {
    if (_stateGet is SuccessTournamentGetState) {
      Tournament tournament =
          (_stateGet as SuccessTournamentGetState).tournament;
    }
  }
}
