import 'package:chess_versus/src/domain/models/player/player.dart';
import 'package:uuid/uuid.dart';

import '../../value_objects/name.dart';
import '../../value_objects/score.dart';

class PlayerRawDto {
  final String _tournamentId;

  /// id of the player
  final String _id;

  /// name of the player
  Name _name;

  /// score of the player
  Score _score;

  /// buchholz score of the player
  Score _bucholz;

  PlayerRawDto({
    required String tournamentId,
    required String id,
    required String name,
    //double? score,
    //double? bucholz
  }) : _tournamentId = tournamentId,
       _id = id,
       _name = Name(name),
       _score = Score(0),
       _bucholz = Score(0);

  PlayerRawDto.empty(String tournamentId)
    : _tournamentId = tournamentId,
      _id = const Uuid().v4(),
      _name = Name(''),
      _score = Score(0),
      _bucholz = Score(0);

  String get id => _id;
  Name get name => _name;
  Score get score => _score;
  Score get buchholz => _bucholz;

  void setName(String name) => _name = Name(name);
  void setScore(double score) => _score = Score(score);
  void setBuchholz(double bucholz) => _bucholz = Score(bucholz);

  static PlayerRawDto fromJson(dynamic data) =>
      PlayerRawDto(
          tournamentId: data['tournament_id'],
          id: data['id'],
          name: data['name'],
          // score: data['score'],
          //bucholz: data['bucholz'],
        )
        .._score = Score((data['score'] as num).toDouble())
        .._bucholz = Score((data['bucholz'] as num).toDouble());

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tournament_id': _tournamentId,
      'id': _id,
      'name': _name.toString(),
      'score': _score.toDouble,
      'bucholz': _bucholz.toDouble,
    };
  }

  static Player toPlayer(PlayerRawDto dto) => Player(
    id: dto.id,
    name: dto.name.toString(),
    score: dto.score.toDouble,
    bucholz: dto.buchholz.toDouble,
  );

  static PlayerRawDto fromPlayer(Player player, String tournamentId) =>
      PlayerRawDto(
          tournamentId: tournamentId,
          id: player.id,
          name: player.name.toString(),
        )
        .._score = Score(player.score.toDouble)
        .._bucholz = Score(player.buchholz.toDouble);
}
