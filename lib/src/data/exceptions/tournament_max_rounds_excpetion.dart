class TournamentMaxRoundsExcpetion implements Exception {
  final String message;

  TournamentMaxRoundsExcpetion(this.message);

  @override
  String toString() => 'TournamentMaxRoundsExcpetion: $message';
}
