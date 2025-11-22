import 'package:chess_versus/src/data/exceptions/tournament_update_exception.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';

class TournamentDeleteUseCase {
  final TournamentRepository _repository;
  final _log = Logger('TournamentCreateUseCase');

  TournamentDeleteUseCase({required TournamentRepository tournamentRepository})
    : _repository = tournamentRepository;

  AsyncResult<void> deleteFrom(String id) async {
    try {
      var result = await _repository.delete(id);
      result.fold((onSuccess) {
        _log.fine('Tournament deleted on use case');
      }, (failure) => throw failure);

      return Success(unit);
    } on TournamentUpdateException catch (e) {
      return Failure(e);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
