import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:chess_versus/src/ui/tournament/widgets/content/players_content/view_models/players_state.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/player/player.dart';
import 'player_state_tap.dart';

class PlayersViewModel extends ChangeNotifier {
  final PlayerRepository _repository;
  PlayersState _state = IdlePlayersState();
  PlayerTapState _stateTap = PlayerNotTapped();

  PlayersViewModel({required PlayerRepository playerRepository})
      : _repository = playerRepository;

  PlayersState get state => _state;
  PlayerTapState get stateTap => _stateTap;

  emit(PlayersState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getPlayers(String tournamentId) async {
    emit(LoadingPlayersState());

    (await _repository.fetchByTournamentId(tournamentId))
        .map(SuccessPlayerState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailurePlayersState.new)
        .fold(emit, emit);
  }

  emitPlayerTapped(Player player) {
    _stateTap = PlayerTapped(player);
    notifyListeners();
  }
}
