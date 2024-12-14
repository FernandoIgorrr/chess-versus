import '../../../../../../domain/models/player/player.dart';

sealed class PlayersState {}

class IdlePlayersState extends PlayersState {}

class LoadingPlayersState extends PlayersState {}

class FailurePlayersState extends PlayersState {
  final String message;

  FailurePlayersState(this.message);
}

class SuccessPlayersState extends PlayersState {
  final List<Player> players;

  SuccessPlayersState(this.players);
}
