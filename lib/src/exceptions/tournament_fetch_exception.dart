class TournamentFetchException implements Exception {
  final String message;

  TournamentFetchException(this.message);

  @override
  String toString() => 'TournamentFetchException: $message';
}
