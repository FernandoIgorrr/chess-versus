import '../../../../domain/models/player/player.dart';

sealed class PlayerState {}

class IdlePlayerState extends PlayerState {}

class FailurePlayerState extends PlayerState {
  final String message;

  FailurePlayerState(this.message);
}

class SuccessPlayerState extends PlayerState {
  final Player player;

  SuccessPlayerState(this.player);
}
