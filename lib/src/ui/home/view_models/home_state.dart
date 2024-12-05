import '../../../domain/models/tournament/tournament.dart';

sealed class HomeState {}

class EmptyHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class SucessGetTournamentsState extends HomeState {
  final List<Tournament> tournaments;
  SucessGetTournamentsState(this.tournaments);
}

class FailedGetTournamentsState extends HomeState {
  final String message;
  FailedGetTournamentsState(this.message);
}
