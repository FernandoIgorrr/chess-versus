class RoundCreateException implements Exception {
  final String message;

  RoundCreateException(this.message);

  @override
  String toString() => 'RoundCreateException: $message';
}
