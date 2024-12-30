import 'package:result_dart/result_dart.dart';

import '../../../domain/models/match/match_row_dto.dart';
import '../repository.dart';

abstract class MatchRawDtoRepository implements Repository<MatchRawDto> {
  @override
  AsyncResult<void, Exception> create(MatchRawDto matchRawDto);
  @override
  AsyncResult<MatchRawDto, Exception> findById(String id);
  @override
  AsyncResult<List<MatchRawDto>, Exception> findAll();

  AsyncResult<List<MatchRawDto>, Exception> findByRound(String roundId);
}
