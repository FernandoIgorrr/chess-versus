import 'package:chess_versus/src/domain/models/tournament/tournament_type.dart';

import '../../value_objects/score.dart';
import '../../value_objects/tournament_name.dart';

class TournamentCreateDTO {
  TournamentName _name;
  String? _description;
  DateTime _startedAt;
  TournamentType _type;

  TournamentCreateDTO({
    required String name,
    String? description,
    required DateTime startedAt,
    required TournamentType type,
  }) : _name = TournamentName(name),
       _description = description,
       _startedAt = startedAt,
       _type = type;

  TournamentName get getName => _name;
  String? get getDescription => _description;
  DateTime get getStartedAt => _startedAt;
  TournamentType get getType => _type;
  String get getTypeName => _type.toString();
  Score? getByeScore() {
    if (_type is Swiss) {
      return (_type as Swiss).getByeScore;
    }
    return null;
  }

  void setName(String name) => _name = TournamentName(name);
  void setDescription(String description) => _description = description;
  void setStartedAt(DateTime startedAt) => _startedAt = startedAt;
  void setType(TournamentType type) => _type = type;
  void setByScore(double score) => _type = Swiss(score);

  factory TournamentCreateDTO.empty() => TournamentCreateDTO(
    name: '',
    startedAt: DateTime.now(),
    type: Swiss(0.0),
  );

  @override
  String toString() {
    return 'Tournament(name: $_name, description: $_description, startedAt: $_startedAt, type: $_type), byeScore: ${getByeScore()}';
  }
}
