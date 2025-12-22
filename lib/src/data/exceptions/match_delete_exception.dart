class MatchDeleteException implements Exception {
  final String message;
  MatchDeleteException(this.message);

  @override
  String toString() => 'MatchDeleteException: $message';
}
