import '../../../../domain/models/round/round.dart';

sealed class RoundTapState {}

class RoundNotTapped extends RoundTapState {}

class RoundTapped extends RoundTapState {
  Round round;

  RoundTapped(this.round);
}
