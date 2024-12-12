import 'package:chess_versus/src/domain/value_objects/score.dart';

sealed class TournamentType {
  static TournamentType fromJson(dynamic data) {
    switch (data['name'].toString().toLowerCase()) {
      case 'elimination':
        return Elimination();
      case 'round robin' || 'roundrobin' || 'round-robin':
        return RoundRobin();
      case 'swiss':
        return Swiss((data['byeScore'] as num).toDouble());
      default:
        return Swiss(0.0);
    }
  }

  static Map<String, dynamic> toJson(TournamentType type) {
    if (type is Elimination) {
      return <String, dynamic>{'name': 'Elimination'};
    } else if (type is RoundRobin) {
      return <String, dynamic>{'name': 'Round Robin'};
    } else if (type is Swiss) {
      return <String, dynamic>{
        'name': 'Swiss',
        'byeScore': type._byeScore.toDouble
      };
    }
    return <String, dynamic>{'name': 'Swiss', 'byeScore': 0.0};
  }
}

class Elimination extends TournamentType {
  @override
  String toString() => 'Elimination';
}

class RoundRobin extends TournamentType {
  @override
  String toString() => 'Round Robin';
}

class Swiss extends TournamentType {
  /// Represents the score each player will earn when "facing" the bye
  final Score _byeScore;

  Swiss(double byScore) : _byeScore = Score(byScore);

  Score get getByeScore => _byeScore;

  @override
  String toString() => 'Swiss';
}
