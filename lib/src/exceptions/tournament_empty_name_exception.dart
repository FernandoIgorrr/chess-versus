class TournamentEmptyNameException implements Exception {
  final String message;

  TournamentEmptyNameException(this.message);

  @override
  String toString() => 'TournamentEmptyNameException: $message';
}
