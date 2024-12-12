import '../../../domain/models/tournament/tournament.dart';

sealed class TournamentState {}

class TournamentIdleState extends TournamentState {}

class TournamentLoadingState extends TournamentState {}

class TournamentSuccessState extends TournamentState {
  final Tournament tournament;
  TournamentSuccessState(this.tournament);
}

class TournamentFailureState extends TournamentState {
  final String message;
  TournamentFailureState(this.message);
}
