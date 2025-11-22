class RoundUpdateException implements Exception {
  final String message;

  RoundUpdateException(this.message);

  @override
  String toString() => 'RoundUpdateException: $message';
}
