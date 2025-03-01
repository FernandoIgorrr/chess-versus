import 'package:chess_versus/src/domain/models/tournament/tournament_create_dto.dart';
import 'package:chess_versus/src/data/exceptions/tournament_empty_name_exception.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/tournament/tournament_repository.dart';
import '../../../data/exceptions/tournament_create_exception.dart';
import '../../models/tournament/tournament.dart';

class TournamentCreateUseCase {
  final TournamentRepository _repository;
  final _log = Logger('TournamentCreateUseCase');

  TournamentCreateUseCase({
    required TournamentRepository tournamentRepository,
  }) : _repository = tournamentRepository;

  AsyncResult<Tournament, Exception> createFrom(TournamentCreateDTO dto) async {
    try {
      if (dto.getName.toString().isEmpty) {
        _log.warning('Tournament name is empty from TournamentCreateDTO');
        throw TournamentEmptyNameException(
            "Tournament name is empty from TournamentCreateDTO");
      }

      final tournament = Tournament(
          name: dto.getName.toString(),
          description: dto.getDescription,
          startedAt: dto.getStartedAt,
          type: dto.getType);

      _log.fine('Tournament made from TournamentCreateDTO');

      var result = await _repository.create(tournament);
      result.fold((onSuccess) {
        _log.fine('Tournament created on use case');
      }, (failure) => throw failure);

      return Success(tournament);
    } on TournamentEmptyNameException catch (e) {
      return Failure(e);
    } on TournamentCreateException catch (e) {
      return Failure(e);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
