import '../../../../domain/models/player/player.dart';

sealed class PlayerTapState {}

class PlayerNotTapped extends PlayerTapState {}

class PlayerTapped extends PlayerTapState {
  Player player;

  PlayerTapped(this.player);
}
