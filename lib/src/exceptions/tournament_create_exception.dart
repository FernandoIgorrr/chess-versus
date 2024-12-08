class TournamentCreateException implements Exception {
  final String message;

  TournamentCreateException(this.message);

  @override
  String toString() => 'TournamentCreateException: $message';
}
