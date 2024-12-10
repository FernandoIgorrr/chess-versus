import 'package:uuid/uuid.dart';

import '../../value_objects/name.dart';
import '../../value_objects/score.dart';
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

  ///If the tournament was arquived
  bool _arquived;

  Tournament(
      {String? id,
      required String name,
      String? description,
      required DateTime startedAt,
      required TournamentType type})
      : _id = id ?? const Uuid().v4(),
        _name = Name(name),
        _description = description,
        _startedAt = startedAt,
        _type = type,
        _status = TournamentStatus.created,
        _arquived = false;

  ///Get methods of the properties of the tournament
  String get getId => _id;
  Name get getName => _name;
  String? get getDescription => _description;
  DateTime get getStartedAt => _startedAt;
  TournamentType get getType => _type;
  String get getTypeName => _type.toString();
  TournamentStatus get getStatus => _status;
  int? get getTotalNumberOfRounds => _totalNumberOfRounds;
  bool? get getHaveBye => _haveBye;
  Score? get getByeScore => _type is Swiss ? _type.getByeScore : null;

  ///Set methods of the properties of the tournament
  setName(String name) => _name = Name(name);
  setDescription(String description) => _description = description;
  setStartedAt(DateTime startedAt) => _startedAt = startedAt;
  setStatus(TournamentStatus status) => _status = status;
  setTotalNumberOfRounds(int totalNumberOfRounds) =>
      _totalNumberOfRounds = totalNumberOfRounds;
  setHaveBye(bool haveBye) => _haveBye = haveBye;
  setArquived(bool arquived) => _arquived = arquived;
  setByScore(Score score) => Swiss.new;

  static Tournament fromJson(dynamic data) {
    return Tournament(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      startedAt: DateTime.parse(data['started_at']),
      type: TournamentType.fromJson(data['type']),
    )
      .._status = _$StatusEnumMap[data['status']] ?? TournamentStatus.created
      .._totalNumberOfRounds = data['total_number_of_rounds']
      .._haveBye = data['have_bye']
      .._arquived = data['deleted'];
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
      'delted': tournament._arquived
    };
  }

  @override
  String toString() {
    return 'Tournament(id: $_id, name: $_name, description: $_description, startedAt: $_startedAt, type: $_type, status: $_status, totalNumberOfRounds: $_totalNumberOfRounds, haveBye: $_haveBye)';
  }
}

enum TournamentStatus { created, executing, finished }

const _$StatusEnumMap = {
  'created': TournamentStatus.created,
  'executing': TournamentStatus.executing,
  'finished': TournamentStatus.finished,
};
