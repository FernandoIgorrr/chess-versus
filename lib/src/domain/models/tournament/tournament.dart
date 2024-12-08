import 'package:uuid/uuid.dart';

import '../../value_objects/name.dart';
import '../../value_objects/total_number_of_rounds.dart';
import 'tournament_type.dart';

class Tournament {
  /// Tournament identifier
  final String _id;

  /// Tournament name to display
  Name _name;

  /// Tournament description to display
  String? _description;

  /// Tournament start date
  DateTime _startedAt;

  /// Tournament type
  final TournamentType _type;

  /// Maximum number of rounds
  int? _totalNumberOfRounds; // number of rounds

  /// Tournament status. Represents the progress of the tournament.
  /// if it's executing or if it's finished, if can add more players...
  TournamentStatus _status;

  /// Represents whether the tournament has a bye (to adjust the pairing
  ///  in tournaments with an odd number of players) or not
  /// (only legs in Swiss tournaments)
  bool? _haveBye;

  ///Case the tournamente the be deleted
  bool _deleted;

  Tournament(
      {String? id,
      required Name name,
      String? description,
      required DateTime startedAt,
      required TournamentType type})
      : _id = id ?? const Uuid().v4(),
        _name = name,
        _description = description,
        _startedAt = startedAt,
        _type = type,
        _status = TournamentStatus.created,
        _deleted = false;

  ///Get methods of the properties of the tournament
  String get getId => _id;
  String get getName => _name.toString();
  String? get getDescription => _description;
  DateTime get getStartedAt => _startedAt;
  TournamentType get getType => _type;
  String get getTypeName => _type.toString();
  TournamentStatus get getStatus => _status;
  int? get getTotalNumberOfRounds => _totalNumberOfRounds;
  bool? get getHaveBye => _haveBye;
  double? get getByeScore => _type is Swiss ? _type.getByeScore : null;

  ///Set methods of the properties of the tournament
  void setName(String name) => _name = Name(name);
  void setDescription(String description) => _description = description;
  void setStartedAt(DateTime startedAt) => _startedAt = startedAt;
  void setStatus(TournamentStatus status) => _status = status;
  void setTotalNumberOfRounds(int totalNumberOfRounds) =>
      _totalNumberOfRounds = totalNumberOfRounds;
  void setHaveBye(bool haveBye) => _haveBye = haveBye;

  static Tournament fromJson(dynamic data) {
    return Tournament(
      id: data['id'],
      name: Name(data['name']),
      description: data['description'],
      startedAt: DateTime.parse(data['started_at']),
      type: TournamentType.fromJson(data['type']),
    )
      .._status = _$StatusEnumMap[data['status']] ?? TournamentStatus.created
      .._totalNumberOfRounds = data['total_number_of_rounds']
      .._haveBye = data['have_bye']
      .._deleted = data['deleted'];
  }

  Map<String, dynamic> toJson(Tournament tournament) {
    return <String, dynamic>{
      'id': tournament._id,
      'name': tournament._name,
      'description': tournament._description,
      'started_at': tournament._startedAt,
      'type': TournamentType.toJson(tournament._type),
      'status': tournament._status.name,
      'total_number_of_rounds': tournament._totalNumberOfRounds,
      'have_bye': tournament._haveBye,
      'delted': tournament._deleted
    };
  }
}

enum TournamentStatus { created, executing, finished }

const _$StatusEnumMap = {
  'created': TournamentStatus.created,
  'executing': TournamentStatus.executing,
  'finished': TournamentStatus.finished,
};
