sealed class TournamentType {
  static TournamentType fromJson(dynamic data) {
    switch (data['type']['name'].toString().toLowerCase()) {
      case 'elimination':
        return Elimination();
      case 'round robin' || 'roundrobin' || 'round-robin':
        return RoundRobin();
      case 'swiss':
        return Swiss(data['type']['byeScore']);
      default:
        return Swiss(0.0);
    }
  }

  static Map<String, dynamic> toJson(TournamentType type) {
    if (type is Elimination) {
      return {
        'type': <String, dynamic>{'name': 'Elimination'}
      };
    } else if (type is RoundRobin) {
      return {
        'type': <String, dynamic>{'name': 'Round Robin'}
      };
    } else if (type is Swiss) {
      return {
        'type': <String, dynamic>{
          'name': 'Swiss',
          if (type._byeScore != null) 'byeScore': type._byeScore
        }
      };
    }
    return {
      'type': <String, dynamic>{'name': 'Swiss'}
    };
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
  final double? _byeScore;

  Swiss(this._byeScore);

  double? get getByeScore => _byeScore;

  @override
  String toString() => 'Swiss';
}
