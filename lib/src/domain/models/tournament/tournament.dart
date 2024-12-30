import 'package:uuid/uuid.dart';

import '../../value_objects/name.dart';
import '../../value_objects/score.dart';
import '../player/player.dart';
import '../round/round.dart';
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

  ///list of players from the tournament
  List<Player> _players;

  /// Total number of rounds
  int? _totalNumberOfRounds; // number of rounds

  /// List of rounds from the tournament
  List<Round> _rounds;

  /// Tournament status. Represents the progress of the tournament.
  /// if it's executing or if it's finished, if can add more players...
  TournamentStatus _status;

  /// Represents whether the tournament has a bye (to adjust the pairing
  ///  in tournaments with an odd number of players) or not
  /// (only legs in Swiss tournaments)
  bool? _haveBye;

  ///If the tournament was arquived
  bool _arquived;

  Tournament({
    String? id,
    required String name,
    String? description,
    required DateTime startedAt,
    required TournamentType type,
    List<Player>? players,
    List<Round>? rounds,
  })  : _id = id ?? const Uuid().v4(),
        _name = Name(name),
        _description = description,
        _startedAt = startedAt,
        _type = type,
        _status = TournamentStatus.created,
        _players = players ?? <Player>[],
        _rounds = rounds ?? <Round>[],
        _arquived = false;

  ///Get methods of the properties of the tournament
  String get id => _id;
  Name get name => _name;
  String? get description => _description;
  DateTime get startedAt => _startedAt;
  TournamentType get type => _type;
  String get typeName => _type.toString();
  TournamentStatus get status => _status;
  List<Player> get players => _players;
  int? get totalNumberOfRounds => _totalNumberOfRounds;
  List<Round> get rounds => _rounds;
  bool? get haveBye => _haveBye;
  Score? get byeScore => _type is Swiss ? _type.getByeScore : null;

  int get numberOfPlayers => _players.length;

  ///Set methods of the properties of the tournament
  setName(String name) => _name = Name(name);
  setDescription(String description) => _description = description;
  setStartedAt(DateTime startedAt) => _startedAt = startedAt;
  setStatus(TournamentStatus status) => _status = status;
  setPlayers(List<Player> players) => _players = players;
  setTotalNumberOfRounds(int totalNumberOfRounds) =>
      _totalNumberOfRounds = totalNumberOfRounds;
  setRounds(List<Round> rounds) => _rounds = rounds;
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
      .._totalNumberOfRounds = data['total_number_of_rounds'] as int?
      .._haveBye = data['have_bye'] as bool?
      .._arquived = data['arquived'] as bool;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': _id,
      'name': _name.toString(),
      'description': _description,
      'started_at': _startedAt.toIso8601String(),
      'type': TournamentType.toJson(_type),
      'status': _status.name,
      'total_number_of_rounds': _totalNumberOfRounds,
      'have_bye': _haveBye,
      'arquived': _arquived
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
