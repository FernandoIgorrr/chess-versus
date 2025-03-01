class PlayerImpossibleNameException implements Exception {
  final String message;

  PlayerImpossibleNameException(this.message);

  @override
  String toString() => 'PlayerImpossibleNameException: $message';
}
