import 'package:uuid/uuid.dart';
import '../player/player.dart';
import '../match/match.dart';

class Round {
  final String _id;

  final int _roundNumber;

  List<Match> _matches;

  Player? _notPaired;

  Round({
    String? id,
    required int roundNumber,
    Player? notPaired,
    List<Match>? matches,
  })  : _id = id ?? const Uuid().v4(),
        _roundNumber = roundNumber,
        _matches = matches ?? <Match>[],
        _notPaired = notPaired;

  String get id => _id;
  int get roundNumber => _roundNumber;
  Player? get notPaired => _notPaired;
  List<Match> get matches => _matches;

  void setMatches(List<Match> matches) => _matches = matches;
  set notPaired(Player? player) => _notPaired = player;
}
