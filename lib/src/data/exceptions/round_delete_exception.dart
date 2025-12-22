class RoundDeleteException implements Exception {
  final String message;

  RoundDeleteException(this.message);

  @override
  String toString() => 'RoundDeleteException: $message';
}
