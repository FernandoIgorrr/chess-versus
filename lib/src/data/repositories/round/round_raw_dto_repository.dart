import 'package:result_dart/result_dart.dart';

import '../../../domain/models/round/round_raw_dto.dart';
import '../repository.dart';

abstract class RoundRawDtoRepository implements Repository<RoundRawDto> {
  /// Creates a new [RoundRawDto].
  @override
  AsyncResult<void> create(RoundRawDto round);

  /// Returns the list of [RoundRawDto] for the application.
  @override
  AsyncResult<List<RoundRawDto>> findAll();

  /// Returns the list of [RoundRawDto] of a determined tournament
  AsyncResult<List<RoundRawDto>> findByTournament(
      String tournamentId);

  /// Updates the [RoundRawDto] with the given [id].
  // Future<Result<void>> update(Tournament tournament);

  /// Returns the [RoundRawDto] with the given [id].
  // Future<Result<void>> delete(String id);
}
