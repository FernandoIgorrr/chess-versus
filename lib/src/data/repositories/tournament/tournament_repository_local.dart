import 'package:chess_versus/src/domain/models/tournament/tournament.dart';

import 'package:chess_versus/src/utils/result.dart';

import 'tournament_repository.dart';

class TournamentRepositoryLocal implements TournamentRepository {
  @override
  Future<Result<void>> createBooking(Tournament tournament) {
    // TODO: implement createBooking
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Tournament>>> fetchAll() async {
    await Future.delayed(const Duration(seconds: 2));
    return Result.ok([
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
    ]);
  }

  @override
  Future<Result<Tournament>> fetchById(String id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> update(Tournament tournament) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
