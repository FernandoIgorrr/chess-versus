import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../data/repositories/player/player_repository.dart';
import '../../../../domain/models/player/player.dart';
import 'player_state_tap.dart';
import 'players_state.dart';

class PlayersViewModel extends ChangeNotifier {
  final PlayerRepository _repository;
  PlayersState _state = IdlePlayersState();
  PlayerTapState _stateTap = PlayerNotTapped();
  final _log = Logger('PlayersViewModel');
  PlayersViewModel({required PlayerRepository playerRepository})
      : _repository = playerRepository;

  PlayersState get state => _state;
  PlayerTapState get stateTap => _stateTap;

  emit(PlayersState state) {
    _log.fine('emit: $state');
    _state = state;
    notifyListeners();
  }

  Future<void> getPlayers(String tournamentId) async {
    _log.fine('Start load players');

    emit(LoadingPlayersState());

    (await _repository.findBySuperclassId(tournamentId))
        .map(SuccessPlayersState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailurePlayersState.new)
        .fold(emit, emit);
    _log.fine('Loaded players');
  }

  emitPlayerTapped(Player player) {
    _stateTap = PlayerTapped(player);
    notifyListeners();
  }
}
