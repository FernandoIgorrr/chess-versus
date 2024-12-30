import '../player/player.dart';

class Match {
  final String _table;
  Player _white;
  Player _black;
  Result? _result;
  bool _desqualified;
  bool _immutable = false;

  Match({
    required String table,
    required Player white,
    required Player black,
    Result? result,
    bool? desqualified,
    bool? immutable,
  })  : _table = table,
        _white = white,
        _black = black,
        _result = result,
        _desqualified = desqualified ?? false,
        _immutable = immutable ?? false;

  String get table => _table;
  Player get white => _white;
  Player get black => _black;
  Result? get result => _result;
  bool get desqualified => _desqualified;
  bool get immutable => _immutable;

  set setWhite(Player player) => _white = player;
  set setBlack(Player player) => _black = player;

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
}

enum Result { white, black, draw, bothLose, woWhite, woBlack }
