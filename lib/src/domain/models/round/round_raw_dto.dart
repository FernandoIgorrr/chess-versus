import 'package:uuid/uuid.dart';

import '../player/player.dart';
import 'round.dart';

class RoundRawDto {
  final String _tournamentId;

  final String _id;

  int _roundNumber;

  String? _notPaired;

  RoundRawDto({
    required String tournamentId,
    required String? id,
    required int roundNumber,
    String? notPaired,
    //double? score,
    //double? bucholz
  }) : _tournamentId = tournamentId,
       _id = id ?? const Uuid().v4(),
       _roundNumber = roundNumber,
       _notPaired = notPaired;

  RoundRawDto.empty(String tournamentId)
    : _tournamentId = tournamentId,
      _id = const Uuid().v4(),
      _roundNumber = 0,
      _notPaired = null;

  String get id => _id;
  int get roundNumber => _roundNumber;
  String? get notPaired => _notPaired;

  void setRoundNumber(int roundNumber) => _roundNumber = roundNumber;
  void setNotPaired(String notPaired) => _notPaired = notPaired;

  static RoundRawDto fromJson(dynamic data) => RoundRawDto(
    tournamentId: data['tournament_id'],
    id: data['id'],
    roundNumber: data['round_number'],
    notPaired: data['not_paired'],
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tournament_id': _tournamentId,
      'id': _id,
      'round_number': _roundNumber,
      'not_paired': _notPaired,
    };
  }

  static Round toRound(RoundRawDto dto) => Round(
    id: dto.id,
    roundNumber: dto.roundNumber,
    notPaired: dto.notPaired == null
        ? null
        : Player(id: dto.notPaired, name: ''),
  );

  static RoundRawDto fromRound(Round round, String tournamentId) => RoundRawDto(
    tournamentId: tournamentId,
    id: round.id,
    roundNumber: round.roundNumber,
    notPaired: round.notPaired?.id,
  );
}
