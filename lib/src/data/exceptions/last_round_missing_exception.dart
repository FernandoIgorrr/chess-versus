class LastRoundMissingException implements Exception {
  final String message;

  LastRoundMissingException(this.message);

  @override
  String toString() => 'LastRoundMissingException: $message';
}
