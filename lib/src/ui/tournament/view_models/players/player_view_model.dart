import 'package:chess_versus/src/domain/models/player/player.dart';
import 'package:chess_versus/src/ui/tournament/view_models/players/player_state.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../domain/use_cases/tournament/player_create_use_case.dart';

class PlayerViewModel extends ChangeNotifier {
  final PlayerCreateUseCase _playerCreateUseCase;
  PlayerState _state = IdlePlayerState();
  final _log = Logger('PlayerViewModel');
  Player player = Player.empty();
  PlayerViewModel({required PlayerCreateUseCase playerCreateUseCase})
    : _playerCreateUseCase = playerCreateUseCase;

  PlayerState get state => _state;

  emit(PlayerState state) {
    _state = state;
    // if (state is SuccessPlayerState) player = Player.empty();
    notifyListeners();
  }

  Future<void> create(Player player, String tournamentId) async {
    _log.fine('create');
    var result = await _playerCreateUseCase.createFrom(tournamentId, player);

    result
        .map(SuccessPlayerState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailurePlayerState.new)
        .fold(emit, emit);
  }

  emptyPlayer() {
    player = Player.empty(); // Isso deve criar um novo UUID
    emit(IdlePlayerState());
  }
}
