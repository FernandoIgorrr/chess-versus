import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../../domain/use_cases/tournament/tournament_delete_use_case.dart';
import 'home_state.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required TournamentRepository tournamentRepository,
    required TournamentDeleteUseCase tournamentDeleteUseCase,
  }) : _tournamentRepository = tournamentRepository,
       _tournamentDeleteUseCase = tournamentDeleteUseCase;

  final TournamentDeleteUseCase _tournamentDeleteUseCase;
  HomeState _state = EmptyTournamentsState();
  final TournamentRepository _tournamentRepository;

  //final _log = Logger('HomeViewModel');

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
        .mapError((error) => error.toString())
        .mapError(FailureGetTournamentsState.new)
        .fold(emit, emit);
    //_log.fine('Loaded tournaments');
  }

  Future<void> deleteTournament(String id) async {
    await _tournamentDeleteUseCase.deleteFrom(id);
    //_log.fine('Deleted tournament');
  }
}
