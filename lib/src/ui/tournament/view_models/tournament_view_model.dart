import 'package:chess_versus/src/data/repositories/tournament/tournament_repository.dart';
import 'package:chess_versus/src/ui/tournament/view_models/tournament_state.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class TournamentViewModel extends ChangeNotifier {
  final TournamentRepository _repository;
  TournamentState _state = TournamentIdleState();
  final _log = Logger('TourmanetViewModel');
  TournamentViewModel({required TournamentRepository tournamentRepository})
      : _repository = tournamentRepository;

  TournamentState get state => _state;

  emit(TournamentState state) {
    _state = state;
    _log.fine('Notifying listeners: $state');
    if (state is TournamentFailureState) {
      _log.warning('erro: ${state.message}');
    }
    notifyListeners();
  }

  Future<void> getTournament(String id) async {
    _log.fine('getTournament');
    (await _repository.findById(id))
        .map(TournamentSuccessState.new)
        .mapError((failure) => failure.toString())
        .mapError(TournamentFailureState.new)
        .fold(emit, emit);
  }
}
