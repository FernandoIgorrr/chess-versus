import 'package:uuid/uuid.dart';

class Tournament {
  /// Tournament identifier
  final String _id;

  /// Tournament name to display
  String _name;

  /// Tournament description to display
  String? _description;

  /// Tournament start date
  DateTime _startedAt;

  /// Tournament type
  final TournamentType _type;

  /// Maximum number of rounds
  int _maximumNumberOfRounds; // number of rounds

  /// Tournament status. Represents the progress of the tournament.
  /// if it's executing or if it's finished, if can add more players...
  TournamentStatus _status;

  /// Represents whether the tournament has a bye (to adjust the pairing
  ///  in tournaments with an odd number of players) or not
  /// (only legs in Swiss tournaments)
  bool _haveBye;

  /// Represents the score each player will earn when "facing" the bye
  double? _byeScore;

  Tournament({
    String? id,
    required String name,
    String? description,
    required DateTime startedAt,
    required TournamentType type,
    double? byeScore,
  })  : _byeScore = byeScore,
        _type = type,
        _maximumNumberOfRounds = 0,
        _startedAt = startedAt,
        _description = description,
        _name = name,
        _id = id ?? const Uuid().v4(),
        _haveBye = false,
        _status = TournamentStatus.created;

  ///Get methods of the properties of the tournament
  String get getId => _id;
  String get getName => _name;
  String? get getDescription => _description;
  DateTime get getStartedAt => _startedAt;
  TournamentType get getType => _type;
  String get getTypeName => _type.name;
  TournamentStatus get getStatus => _status;
  int get getMaximumNumberOfRounds => _maximumNumberOfRounds;
  bool get getHaveBye => _haveBye;
  double? get getByeScore => _byeScore;

  ///Set methods of the properties of the tournament
  void setName(String name) => _name = name;
  void setDescription(String? description) => _description = description;
  void setStartedAt(DateTime startedAt) => _startedAt = startedAt;
  void setStatus(TournamentStatus status) => _status = status;
  void setMaximumNumberOfRounds(int maximumNumberOfRounds) =>
      _maximumNumberOfRounds = maximumNumberOfRounds;
  void setHaveBye(bool haveBye) => _haveBye = haveBye;
  void setByeScore(double? byeScore) => _byeScore = byeScore;
}

enum TournamentType { swiss, roundRobin, elimination }

enum TournamentStatus { created, executing, finished }
