import 'package:chess_versus/src/data/exceptions/round_create_exception.dart';
import 'package:chess_versus/src/data/exceptions/rounds_fetch_expetion.dart';
import 'package:chess_versus/src/data/exceptions/tournament_fetch_exception.dart';
import 'package:logging/logging.dart';

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
  AsyncResult<void, RoundCreateException> create(
      Round round, String tournamentId) async {
    (await _repository.create(RoundRawDto.fromRound(round, tournamentId)))
        .getOrThrow();
    return const Success(unit);
  }

  @override
  AsyncResult<List<Round>, RoundsFetchException> findAll() async {
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
  AsyncResult<List<Round>, Exception> findBySuperclassId(
      String tournamentId) async {
    //_log.fine('findByTournamentId: $tournamentId');
    try {
      final response =
          await _repository.findByTournament(tournamentId).getOrElse((failure) {
        throw failure;
      });

      return Success(response.map(RoundRawDto.toRound).toList());
    } catch (e) {
      return Failure(TournamentFetchExcpetion(e.toString()));
    }
  }

  @override
  AsyncResult<Round, Exception> findById(String id) {
    throw UnimplementedError();
  }
}
