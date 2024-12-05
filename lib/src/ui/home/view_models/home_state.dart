import '../../../domain/models/tournament/tournament.dart';

sealed class HomeState {}

class EmptyTournamentsState extends HomeState {}

class LoadingTournamentsState extends HomeState {}

class SucessGetTournamentsState extends HomeState {
  final List<Tournament> tournaments;
  SucessGetTournamentsState(this.tournaments);
}

class FailedGetTournamentsState extends HomeState {
  final String message;
  FailedGetTournamentsState(this.message);
}
