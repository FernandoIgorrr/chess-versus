class MatchesFetchException implements Exception {
  final String message;

  MatchesFetchException(this.message);

  @override
  String toString() => 'MatchesFetchException: $message';
}
