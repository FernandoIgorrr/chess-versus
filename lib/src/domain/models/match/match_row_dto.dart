import 'package:chess_versus/src/domain/models/match/match.dart';

import '../player/player.dart';

class MatchRawDto {
  String roundId;
  String table;
  String white;
  String black;
  Result? result;
  bool desqualified;
  bool immutable;

  MatchRawDto({
    required this.roundId,
    required this.table,
    required this.white,
    required this.black,
    required this.desqualified,
    required this.immutable,
    Result? result,
  });

  static MatchRawDto fromJson(dynamic data) => MatchRawDto(
        roundId: data['round_id'],
        table: data['table'],
        white: data['white'],
        black: data['black'],
        result: _$ResultEnumMap[data['result']],
        desqualified: data['desqualified'],
        immutable: data['immutable'],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'round_id': roundId,
      'table': table,
      'white': white,
      'black': black,
      'result': result?.name,
      'desqualified': desqualified,
      'immutable': immutable
    };
  }

  static Match toMatch(MatchRawDto dto) => Match(
        table: dto.table,
        white: Player(id: dto.white, name: ''),
        black: Player(id: dto.black, name: ''),
        result: dto.result,
        desqualified: dto.desqualified,
        immutable: dto.immutable,
      );

  static MatchRawDto fromMatch(Match match, String roundId) => MatchRawDto(
        roundId: roundId,
        table: match.table,
        white: match.white.id,
        black: match.black.id,
        result: match.result,
        desqualified: match.desqualified,
        immutable: match.immutable,
      );
}

const _$ResultEnumMap = {
  'white': Result.white,
  'black': Result.black,
  'draw': Result.draw,
  'bothLose': Result.bothLose,
  'woWhite': Result.woWhite,
  'woBlack': Result.woBlack,
};
