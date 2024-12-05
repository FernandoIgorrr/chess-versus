import 'package:chess_versus/src/ui/home/view_models/home_state.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required TournamentRepository tournamentRepository})
      : _tournamentRepository = tournamentRepository;

  HomeState _state = EmptyHomeState();
  final TournamentRepository _tournamentRepository;

  final _log = Logger('HomeViewModel');

  void emit(HomeState state) {
    _state = state;
  }

  Future<void> getTournaments() async {
    emit(LoadingHomeState());

    final result = await _tournamentRepository
        .fetchAll() //
        .map(SucessGetTournamentsState.new)
        .mapError((error) => error.message)
        .mapError(FailedGetTournamentsState.new);

    result //
        .fold(emit, emit);
  }
}
