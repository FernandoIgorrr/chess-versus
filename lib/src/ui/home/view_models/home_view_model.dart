import 'package:chess_versus/src/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../../domain/models/tournament/tournament.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required TournamentRepository tournamentRepository})
      : _tournamentRepository = tournamentRepository;

  final TournamentRepository _tournamentRepository;
  final _log = Logger('HomeViewModel');

  List<Tournament> _tournaments = [];

  Future<Result> getAllTournaments() async {
    try {
      final result = await _tournamentRepository.fetchAll();

      switch (result) {
        case Ok<List<Tournament>>():
          _tournaments = result.value;
          _log.fine('Loaded tournaments');
        case Error<List<Tournament>>():
          _log.warning('Failed to load tournaments', result.error);
          return result;
      }

      return result;
    } finally {
      notifyListeners();
    }
  }
}
