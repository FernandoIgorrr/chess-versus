import 'package:chess_versus/src/domain/value_objects/name.dart';
import 'package:chess_versus/src/domain/value_objects/score.dart';
import 'package:uuid/uuid.dart';

class Player {
  /// id of the player
  final String _id;

  /// name of the player
  Name _name;

  /// score of the player
  Score _score;

  /// buchholz score of the player
  Score _buchholz;

  Player({
    required String? id,
    required String name,
    double? score,
    double? bucholz,
  }) : _id = id ?? const Uuid().v4(),
       _name = Name(name),
       _score = Score(score ?? 0),
       _buchholz = Score(bucholz ?? 0);

  Player.empty()
    : _id = const Uuid().v4(),
      _name = Name(''),
      _score = Score(0),
      _buchholz = Score(0);

  String get id => _id;
  Name get name => _name;
  Score get score => _score;
  Score get buchholz => _buchholz;

  void setName(String name) => _name = Name(name);
  void setScore(double score) => _score = Score(score);
  //void setBuchholz(double bucholz) => _buchholz = Score(bucholz);

  void setBuchholz(List<Player> opponents) =>
      _buchholz =
          opponents.isEmpty
              ? Score(0)
              : opponents
                  .map((player) => player.score)
                  .toList()
                  .reduce((a, b) => Score(a.toDouble + b.toDouble));

  @override
  String toString() =>
      '{\nid: $_id, \nname: $_name, \nscore: $_score, \nbucholz: $_buchholz\n}';
}
