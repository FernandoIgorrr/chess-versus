import 'package:chess_versus/src/data/repositories/tournament/tournament_repository.dart';
import 'package:chess_versus/src/domain/models/tournament/tournament_create_dto.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_create_use_case.dart';
import 'package:chess_versus/src/ui/tournament_form/view_models/form_state.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/tournament/tournament.dart';

class TournamentFormViewModel extends ChangeNotifier {
  final TournamentCreateUseCase _createUseCase;
  TournamentFormState _state = TournamentFormIdleState();

  Tournament? _tournament;

  final _log = Logger('TournamentFormViewModel');

  TournamentFormViewModel(this._createUseCase);

  Tournament? get tournament => _tournament;

  TournamentFormState get state => _state;

  createTournament(TournamentCreateDTO dto) => _createTournament(dto);

  emit(TournamentFormState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> _createTournament(TournamentCreateDTO dto) async {
    _log.fine('Creating tournament');
    await _createUseCase
        .createFrom(dto)
        .map(TournamentFormSuccessState.new)
        .mapError(
          (error) => error.toString(),
        )
        .mapError(TournamentFormFailureState.new)
        .fold(emit, emit);
    _log.fine('Tournament created');
  }
}
