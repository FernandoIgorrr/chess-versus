import 'package:chess_versus/src/domain/models/tournament/tournament.dart';

sealed class RoundsState {}

class IdleRoundsState extends RoundsState {}

class LoadingRoundsState extends RoundsState {}

class SuccessRoundsState extends RoundsState {
  final Tournament tournament;
  SuccessRoundsState(this.tournament);
}

class FailureRoundsState extends RoundsState {
  final String message;
  FailureRoundsState(this.message);
}
