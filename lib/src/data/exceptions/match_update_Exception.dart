class MatchUpdateException implements Exception {
  final String message;

  MatchUpdateException(this.message);

  @override
  String toString() => 'MatchUpdateException: $message';
}
