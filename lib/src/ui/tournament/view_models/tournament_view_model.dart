import 'package:flutter/material.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../../domain/models/tournament/tournament.dart';
import '../../../domain/use_cases/tournament/tournament_load_use_case.dart';
import '../../../domain/use_cases/tournament/tournament_update_use_case.dart';
import 'tournament_get_state.dart';

class TournamentViewModel extends ChangeNotifier {
  final TournamentRepository _tournamentRepository;
  final TournamentUpdateUseCase _tournamentUpdateUseCase;
  final TournamentLoadUseCase _tournamentLoadUseCase;

  //TournamentState _state = IdleTournamentState();
  TournamentGetState _getState = IdleTournamentGetState();

  //final _log = Logger('TourmanetViewModel');

  TournamentViewModel({
    required TournamentRepository tournamentRepository,
    required TournamentUpdateUseCase tournamentUpdateUseCase,
    required TournamentLoadUseCase tournamentLoadUseCase,
  }) : _tournamentRepository = tournamentRepository,
       _tournamentUpdateUseCase = tournamentUpdateUseCase,
       _tournamentLoadUseCase = tournamentLoadUseCase;

  TournamentGetState get getState => _getState;

  void emit(TournamentGetState state) {
    _getState = state;
    notifyListeners();
  }

  /*Future<void> getTournament(String id) async {
    // _log.fine('getTournament');
    (await _tournamentRepository.findById(id))
        .map(SuccessTournamentGetState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureTournamentGetState.new)
        .fold(emit, emit);

    //assemblyTournament(id);
  }*/

  Future<void> assemblyTournament(String tournamentId) async {
    //_log.fine('Start Assembly tournament!!!');
    emit(LoadingTournamentGetState());
    (await _tournamentLoadUseCase.assemblyTournament(tournamentId))
        .map(SuccessTournamentGetState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureTournamentGetState.new)
        .fold(emit, emit);
  }

  Future<void> updateTournament(Tournament tournament) async {
    emit(LoadingTournamentGetState());
    (await _tournamentUpdateUseCase.updateFrom(tournament));
    /*await _tournamentLoadUseCase
        .assemblyTournament(tournament.id)
        .map(SuccessRoundsState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureRoundsState.new)
        .fold(emit, emit);*/
    //_log.fine('Loaded rounds');
  }
}
