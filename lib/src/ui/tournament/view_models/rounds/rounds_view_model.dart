import 'package:chess_versus/src/data/repositories/round/round_repository.dart';
import 'package:chess_versus/src/domain/models/tournament/tournament.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/round_delete_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_pairing_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_load_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_update_use_case.dart';
import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_state.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../domain/models/round/round.dart';
import 'round_tap_state.dart';

class RoundsViewModel extends ChangeNotifier {
  final TournamentLoadUseCase _tournamentLoadUseCase;
  final TournamentUpdateUseCase _tournamentUpdateUseCase;
  final TournamentPairingUseCase _tournamentPairingUseCase;
  final RoundDeleteUseCase _roundDeleteUseCase;
  RoundTapState _stateTap = RoundNotTapped();

  //final _log = Logger('RoundsViewModel');

  RoundsState _state = IdleRoundsState();

  RoundsViewModel({
    required TournamentLoadUseCase tournamentLoadUseCase,
    required TournamentUpdateUseCase tournamentUpdateUseCase,
    required TournamentPairingUseCase tournamentPairingUseCase,
    required RoundRepository roundRepository,
    required RoundDeleteUseCase roundDeleteUseCase,
  }) : _tournamentLoadUseCase = tournamentLoadUseCase,
       _tournamentUpdateUseCase = tournamentUpdateUseCase,
       _tournamentPairingUseCase = tournamentPairingUseCase,
       _roundDeleteUseCase = roundDeleteUseCase;

  RoundsState get state => _state;
  RoundTapState get stateTap => _stateTap;

  void emit(RoundsState state) {
    _state = state;
    notifyListeners();
  }

  void emitRoundTapped(Round round) {
    _stateTap = RoundTapped(round);
    notifyListeners();
  }

  /* Future<void> getRounds(String tournamentId) async {
    _log.fine('Start load rounds');

    emit(LoadingRoundsState());

    (await _roundRepository.findBySuperclassId(tournamentId))
        .map(SuccessRoundsState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureRoundsState.new)
        .fold(emit, emit);
    _log.fine('Loaded rounds');
  }*/

  Future<void> assemblyTournament(String tournamentId) async {
    //_log.fine('Start Assembly tournament!!!');
    emit(LoadingRoundsState());
    await _tournamentLoadUseCase
        .assemblyTournament(tournamentId)
        .map(SuccessRoundsState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureRoundsState.new)
        .fold(emit, emit);
    //_log.fine('Loaded rounds');
  }

  void toPair(Tournament tournament) {
    //_log.fine('Start Pairing players!!!');
    //emit(LoadingRoundsState());
    _tournamentPairingUseCase.pairingFrom(tournament);
    // _log.fine('Paired players!!!!!');
  }

  Future<void> updateTournament(Tournament tournament) async {
    emit(LoadingRoundsState());
    (await _tournamentUpdateUseCase.updateFrom(tournament)).getOrThrow();
    //_log.fine('Loaded rounds');
  }

  Future<void> deleteRound(String roundId) async {
    emit(LoadingRoundsState());
    (await _roundDeleteUseCase.deleteRoundAndMatches(roundId)).getOrThrow();
  }
}
