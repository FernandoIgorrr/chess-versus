import 'package:chess_versus/src/domain/models/match/match.dart';
import 'package:uuid/uuid.dart';

import '../player/player.dart';

class MatchRawDto {
  final String _roundId;
  final String _id;
  String _table;
  String _white;
  String _black;
  Result? _result;
  bool _desqualified;
  bool _immutable;

  MatchRawDto({
    required String roundId,
    required String? id,
    required String table,
    required String white,
    required String black,
    required bool desqualified,
    required bool immutable,
    Result? result,
  }) : _roundId = roundId,
       _id = id ?? const Uuid().v4(),
       _table = table,
       _white = white,
       _black = black,
       _result = result,
       _desqualified = desqualified,
       _immutable = immutable;

  String get id => _id;
  String get table => _table;
  Result? get notPaired => _result;

  static MatchRawDto fromJson(dynamic data) => MatchRawDto(
    roundId: data['round_id'],
    id: data['id'],
    table: data['table'],
    white: data['white'],
    black: data['black'],
    result: _$ResultEnumMap[data['result']],
    desqualified: data['desqualified'],
    immutable: data['immutable'],
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'round_id': _roundId,
      'id': _id,
      'table': _table,
      'white': _white,
      'black': _black,
      'result': _result?.name,
      'desqualified': _desqualified,
      'immutable': _immutable,
    };
  }

  static Match toMatch(MatchRawDto dto) => Match(
    table: dto._table,
    id: dto._id,
    white: Player(id: dto._white, name: ''),
    black: Player(id: dto._black, name: ''),
    result: dto._result,
    desqualified: dto._desqualified,
    immutable: dto._immutable,
  );

  static MatchRawDto fromMatch(Match match, String roundId) => MatchRawDto(
    roundId: roundId,
    id: match.id,
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
