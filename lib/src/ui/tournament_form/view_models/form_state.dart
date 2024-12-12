import '../../../domain/models/tournament/tournament.dart';

sealed class TournamentFormState {}

class TournamentFormIdleState extends TournamentFormState {}

class TournamentFormSuccessState extends TournamentFormState {
  final Tournament tournament;

  TournamentFormSuccessState(this.tournament);
}

class TournamentFormFailureState extends TournamentFormState {
  final String message;

  TournamentFormFailureState(this.message);
}
