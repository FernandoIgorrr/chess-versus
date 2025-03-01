class PlayerFetchException implements Exception {
  final String message;

  PlayerFetchException(this.message);

  @override
  String toString() => 'PlayerFetchException: $message';
}
