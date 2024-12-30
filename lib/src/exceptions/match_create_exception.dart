class MatchCreateException implements Exception {
  final String message;

  MatchCreateException(this.message);

  @override
  String toString() => 'MatchCreateException: $message';
}
