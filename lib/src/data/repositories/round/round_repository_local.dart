import 'package:chess_versus/src/data/exceptions/rounds_fetch_expetion.dart';
import 'package:chess_versus/src/data/exceptions/tournament_fetch_exception.dart';

import 'package:result_dart/result_dart.dart';

import '../../../domain/models/round/round.dart';
import '../../../domain/models/round/round_raw_dto.dart';
import 'round_raw_dto_repository.dart';
import 'round_repository.dart';

class RoundRepositoryLocal extends RoundRepository {
  final RoundRawDtoRepository _repository;

  //final _log = Logger('PlayerRepositoryLocal');

  RoundRepositoryLocal(this._repository);

  @override
  Future<List<String>> getItems() async => await _repository.getItems();

  @override
  Future<bool> setItems(List<String> values) async =>
      _repository.setItems(values);

  @override
  AsyncResult<void> create(Round round, String tournamentId) async {
    (await _repository.create(
      RoundRawDto.fromRound(round, tournamentId),
    )).getOrThrow();
    return const Success(unit);
  }

  @override
  AsyncResult<List<Round>> findAll() async {
    try {
      final list = (await _repository.findAll()).getOrThrow();

      return Success(list.map(RoundRawDto.toRound).toList());
    } on TournamentFetchExcpetion catch (e) {
      return Failure(RoundsFetchException(e.message));
    } catch (e) {
      return Failure(RoundsFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<List<Round>> findBySuperclassId(String tournamentId) async {
    //_log.fine('findByTournamentId: $tournamentId');
    try {
      final response = await _repository
          .findByTournament(tournamentId)
          .getOrElse((failure) {
            throw failure;
          });

      return Success(response.map(RoundRawDto.toRound).toList());
    } catch (e) {
      return Failure(TournamentFetchExcpetion(e.toString()));
    }
  }

  @override
  AsyncResult<Round> findById(String id) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> update(Round round, String tournamentId) async {
    try {
      await _repository.update(RoundRawDto.fromRound(round, tournamentId));

      return Success(unit);
    } on TournamentFetchExcpetion catch (e) {
      return Failure(RoundsFetchException(e.message));
    } catch (e) {
      return Failure(RoundsFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<void> updateAll(List<Round> rounds, String tournamentId) async {
    try {
      await _repository.updateAll(
        rounds.map((r) => RoundRawDto.fromRound(r, tournamentId)).toList(),
      );

      return Success(unit);
    } catch (e) {
      return Failure(RoundsFetchException(e.toString()));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _repository.delete(id);
      return const Success(unit);
    } catch (e) {
      return Failure(RoundsFetchException(e.toString()));
    }
  }
}
