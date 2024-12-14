class PlayerCreateException implements Exception {
  final String message;

  PlayerCreateException(this.message);

  @override
  String toString() => 'PlayerCreateException: $message';
}
