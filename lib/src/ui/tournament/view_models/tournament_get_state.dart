import '../../../domain/models/tournament/tournament.dart';

sealed class TournamentGetState {}

class IdleTournamentGetState extends TournamentGetState {}

class LoadingTournamentGetState extends TournamentGetState {}

class SuccessTournamentGetState extends TournamentGetState {
  final Tournament tournament;
  SuccessTournamentGetState(this.tournament);
}

class FailureTournamentGetState extends TournamentGetState {
  final String message;
  FailureTournamentGetState(this.message);
}
