import 'package:chess_versus/src/domain/models/tournament/tournament.dart';
import 'package:chess_versus/src/exceptions/tournament_fetch_exception.dart';

import 'package:result_dart/result_dart.dart';

import 'tournament_repository.dart';

class TournamentRepositoryLocal implements TournamentRepository {
  @override
  @override
  AsyncResult<List<Tournament>, TournamentFetchException> fetchAll() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      var list = [
        Tournament(
            name: 'teste 1',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 2',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 3',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 4',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 5',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 6',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 7',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 8',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 9',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
        Tournament(
            name: 'teste 10',
            startedAt: DateTime.now(),
            type: TournamentType.swiss),
      ];

      return Success(list);
    } on TournamentFetchException catch (e) {
      return Failure(TournamentFetchException(message:e.message));
    }
  }
}
