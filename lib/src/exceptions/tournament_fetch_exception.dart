class TournamentFetchExcpetion implements Exception {
  final String message;

  TournamentFetchExcpetion(this.message);

  @override
  String toString() => 'TournamentFetchException: $message';
}
