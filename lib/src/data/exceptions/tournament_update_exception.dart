class TournamentUpdateException implements Exception {
  final String message;

  TournamentUpdateException(this.message);

  @override
  String toString() => 'TournamentUpdateException: $message';
}
