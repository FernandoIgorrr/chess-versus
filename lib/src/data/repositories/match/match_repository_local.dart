import 'package:chess_versus/src/data/exceptions/match_delete_exception.dart';
import 'package:chess_versus/src/data/exceptions/match_update_Exception.dart';
import 'package:chess_versus/src/data/exceptions/matches_fetch_exception.dart';

import 'package:result_dart/result_dart.dart';

import '../../../domain/models/match/match_row_dto.dart';
import '../../../domain/models/match/match.dart' hide Result;
import 'match_raw_dto_repository.dart';
import 'match_repository.dart';

class MatchRepositoryLocal extends MatchRepository {
  final MatchRawDtoRepository _repository;

  //final _log = Logger('PlayerRepositoryLocal');

  MatchRepositoryLocal(this._repository);

  @override
  Future<List<String>> getItems() async => await _repository.getItems();

  @override
  Future<bool> setItems(List<String> values) async =>
      _repository.setItems(values);

  @override
  AsyncResult<void> create(Match match, String superclassId) async {
    (await _repository.create(
      MatchRawDto.fromMatch(match, superclassId),
    )).getOrThrow();
    //_log.fine('crate done');
    return const Success(unit);
  }

  @override
  AsyncResult<List<Match>> findAll() async {
    try {
      final list = (await _repository.findAll()).getOrThrow();

      return Success(list.map(MatchRawDto.toMatch).toList());
    } on MatchesFetchException catch (e) {
      return Failure(MatchesFetchException(e.message));
    } catch (e) {
      return Failure(MatchesFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<List<Match>> findBySuperclassId(String roundId) async {
    try {
      final response = await _repository.findByRound(roundId).getOrElse((
        failure,
      ) {
        throw failure;
      });

      return Success(response.map(MatchRawDto.toMatch).toList());
    } catch (e) {
      return Failure(MatchesFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<Match> findById(String id) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> update(Match match, String roundId) async {
    try {
      await _repository.update(MatchRawDto.fromMatch(match, roundId));

      return Success(unit);
    } on MatchUpdateException catch (e) {
      return Failure(MatchUpdateException(e.message));
    } catch (e) {
      return Failure(MatchUpdateException(e.toString()));
    }
  }

  @override
  AsyncResult<void> updateAll(List<Match> matches, String roundId) async {
    try {
      await _repository.updateAll(
        matches.map((r) => MatchRawDto.fromMatch(r, roundId)).toList(),
      );

      return Success(unit);
    } catch (e) {
      return Failure(MatchUpdateException(e.toString()));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _repository.delete(id);
      return const Success(unit);
    } catch (e) {
      return Failure(MatchDeleteException(e.toString()));
    }
  }
}
