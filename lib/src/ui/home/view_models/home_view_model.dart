import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';
import 'home_state.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required TournamentRepository tournamentRepository})
      : _tournamentRepository = tournamentRepository;

  HomeState _state = EmptyTournamentsState();
  final TournamentRepository _tournamentRepository;

  final _log = Logger('HomeViewModel');

  HomeState get state => _state;

  void emit(HomeState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getTournaments() async {
    emit(LoadingTournamentsState());
    await _tournamentRepository
        .findAll() //
        .map(SucessGetTournamentsState.new)
        .mapError((error) => error.message)
        .mapError(FailureGetTournamentsState.new)
        .fold(emit, emit);
    _log.fine('Loaded tournaments');
  }
}
