class TournamentFetchException implements Exception {
  final String message;

  TournamentFetchException({required this.message});

  @override
  String toString() => 'TournamentFetchException: $message';
}
