import '../../../domain/models/tournament/tournament.dart';

sealed class TournamentState {}

class IdleTournamentState extends TournamentState {}

class LoadingTournamentState extends TournamentState {}

class SuccessTournamentState extends TournamentState {
  final Tournament tournament;
  SuccessTournamentState(this.tournament);
}

class FailureTournamentState extends TournamentState {
  final String message;
  FailureTournamentState(this.message);
}
