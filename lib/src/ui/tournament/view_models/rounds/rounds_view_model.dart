import 'package:chess_versus/src/data/repositories/round/round_repository.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_load_use_case.dart';
import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_state.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

class RoundsViewModel extends ChangeNotifier {
  final RoundRepository _roundRepository;
  final TournamentLoadUseCase _tournamentLoadUseCase;
  //  final PairingUseCase _pairingUseCase;

  final _log = Logger('RoundsViewModel');

  RoundsState _state = IdleRoundsState();

  RoundsViewModel(
      {required TournamentLoadUseCase tournamentLoadUseCase,
      required RoundRepository roundRepository})
      : _tournamentLoadUseCase = tournamentLoadUseCase,
        _roundRepository = roundRepository;

  emit(RoundsState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getRounds(String tournamentId) async {
    _log.fine('Start load rounds');

    emit(LoadingRoundsState());

    (await _roundRepository.findBySuperclassId(tournamentId))
        .map(SuccessRoundsState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureRoundsState.new)
        .fold(emit, emit);
    _log.fine('Loaded rounds');
  }

  /*Future<void> assemblyTournament(String tournamentId) async {
    emit(LoadingRoundsState());
    await _tournamentLoadUseCase
        .assemblyTournament(tournamentId)
        .map(SuccessRoundsState.new)
        .mapError((failure) => failure.toString())
        .mapError(FailureRoundsState.new)
        .fold(emit, emit);
    _log.fine('Loaded rounds');
  }*/
}
