import 'package:uuid/uuid.dart';

import '../player/player.dart';

class Match {
  final String _id;
  String _table;
  Player _white;
  Player _black;
  Result? _result;
  bool _desqualified;
  bool _immutable = false;

  Match({
    String? id,
    required String table,
    required Player white,
    required Player black,
    Result? result,
    bool? desqualified,
    bool? immutable,
  }) : _id = id ?? const Uuid().v4(),
       _table = table,
       _white = white,
       _black = black,
       _result = result,
       _desqualified = desqualified ?? false,
       _immutable = immutable ?? false;

  String get id => _id;
  String get table => _table;
  Player get white => _white;
  Player get black => _black;
  Result? get result => _result;
  bool get desqualified => _desqualified;
  bool get immutable => _immutable;

  //set setId(String id) => _id = id;
  set setWhite(Player player) => _white = player;
  set setBlack(Player player) => _black = player;

  set setTable(String table) => _table = table;

  void fillResult(Result result) => _result = result;

  void doImmutable() => _immutable = true;

  bool get isImmutable => _immutable;

  void fillResultWinner(Player player) {
    if (isOnThisGame(player)) {
      if (player == _white) {
        _result = Result.white;
      } else {
        _result = Result.black;
      }
    }
  }

  void fillResultLoser(Player player) {
    if (isOnThisGame(player)) {
      if (player == _white) {
        _result = Result.black;
      } else {
        _result = Result.white;
      }
    }
  }

  bool get hasResult => _result != null;

  bool isWhite(Player player) => player == _white;
  bool isBlack(Player player) => player == _black;

  double distributeScore(Player player) {
    if (player == _white &&
        (_result == Result.white || _result == Result.woWhite)) {
      return 1.0;
    } else if (player == _black &&
        (_result == Result.black || _result == Result.woBlack)) {
      return 1.0;
    } else if ((player == _white || player == _black) &&
        _result == Result.draw) {
      return 0.5;
    }
    return 0.0;
  }

  bool isOnThisGame(Player player) {
    return player == _white || player == _black;
  }

  Player? getOpponent(Player player) {
    if (player == _white) {
      return _black;
    } else if (player == _black) {
      return _white;
    }
    return null;
  }

  /*
    LEMBRE-SE QUE AQUI A A PRIMEIRA COMPARAÇÃO É O SCORE
    E A SEGUNDA É O BUCHOLZ!!!
  */
  Player get mostScorePlayer => (_white.score.toDouble != _black.score.toDouble)
      ? (_white.score.toDouble > _black.score.toDouble)
            ? _white
            : _black
      : (_white.buchholz.toDouble >= _black.buchholz.toDouble)
      ? _white
      : _black;

  bool equals(Match game) {
    return (game.white == _white || game.black == _white) &&
        (game.white == _black || game.black == _black);
  }

  @override
  String toString() {
    return 'Match(id: $_id, Table: $_table, White: $_white, Black: $_black, Result: $_result  \n )';
  }
}

enum Result { white, black, draw, bothLose, woWhite, woBlack }
