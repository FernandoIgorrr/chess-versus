class PlayerUpdateException implements Exception {
  final String message;
  PlayerUpdateException(this.message);

  @override
  String toString() => 'PlayerUpdateException: $message';
}
