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

  Player(
      {required String? id,
      required String name,
      double? score,
      double? bucholz})
      : _id = id ?? const Uuid().v4(),
        _name = Name(name),
        _score = Score(score ?? 0),
        _buchholz = Score(bucholz ?? 0);

  Player.empty()
      : _id = const Uuid().v4(),
        _name = Name(''),
        _score = Score(0),
        _buchholz = Score(0);

  String get getId => _id;
  Name get getName => _name;
  Score get getScore => _score;
  Score get getBuchholz => _buchholz;

  void setName(String name) => _name = Name(name);
  void setScore(double score) => _score = Score(score);
  void setBuchholz(double bucholz) => _buchholz = Score(bucholz);

  @override
  static Player fromJson(dynamic data) => Player(
        id: data['id'],
        name: data['name'],
      )
        .._score = Score((data['score'] as num).toDouble())
        .._buchholz = Score((data['buchholz'] as num).toDouble());

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': _id,
      'name': _name.toString(),
      'score': _score,
      'buchholz': _buchholz
    };
  }

  @override
  String toString() => toJson().toString();
}
