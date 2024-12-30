import '../../../../domain/models/round/round.dart';

sealed class RoundsState {}

class IdleRoundsState extends RoundsState {}

class LoadingRoundsState extends RoundsState {}

class SuccessRoundsState extends RoundsState {
  final List<Round> rounds;
  SuccessRoundsState(this.rounds);
}

class FailureRoundsState extends RoundsState {
  final String message;
  FailureRoundsState(this.message);
}
