import 'package:chess_versus/src/data/repositories/round/round_repository.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/pairing_use_case.dart';
import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_state.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class RoundsViewModel extends ChangeNotifier {
  final RoundRepository _roundRepository;
//  final PairingUseCase _pairingUseCase;

  final _log = Logger('RoundsViewModel');

  RoundsState _state = IdleRoundsState();

  RoundsViewModel({required RoundRepository roundRepository})
      : _roundRepository = roundRepository;

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
}
