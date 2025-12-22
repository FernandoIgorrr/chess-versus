import 'package:result_dart/result_dart.dart';

import '../../../data/exceptions/round_delete_exception.dart';
import '../../../data/repositories/match/match_repository.dart';
import '../../../data/repositories/round/round_repository.dart';

class RoundDeleteUseCase {
  final MatchRepository _matchRepository;
  final RoundRepository _roundRepository;

  RoundDeleteUseCase({
    required RoundRepository roundRepository,
    required MatchRepository matchRepository,
  }) : _roundRepository = roundRepository,
       _matchRepository = matchRepository;

  AsyncResult<void> deleteRoundAndMatches(String roundId) async {
    try {
      // First, delete all matches associated with the round
      final matches = await _matchRepository.findBySuperclassId(roundId);
      await matches.fold((matches) async {
        for (var match in matches) {
          final deleteMatchResult = await _matchRepository.delete(match.id);
          deleteMatchResult.fold((_) => null, (failure) => throw failure);
        }
      }, (failure) => throw failure);

      // Then, delete the round itself
      final deletedRound = await _roundRepository.delete(roundId);
      return deletedRound;
    } catch (e) {
      return Failure(RoundDeleteException(e.toString()));
    }
  }
}
