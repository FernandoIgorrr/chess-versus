import 'package:result_dart/result_dart.dart';

import '../../../domain/models/match/match_row_dto.dart';
import '../repository.dart';

abstract class MatchRawDtoRepository implements Repository<MatchRawDto> {
  @override
  AsyncResult<void> create(MatchRawDto matchRawDto);
  @override
  AsyncResult<MatchRawDto> findById(String id);
  @override
  AsyncResult<List<MatchRawDto>> findAll();

  AsyncResult<List<MatchRawDto>> findByRound(String roundId);

  @override
  AsyncResult<void> update(MatchRawDto matchRawDto);

  @override
  AsyncResult<void> updateAll(List<MatchRawDto> matches);
}
