class RoundsFetchException implements Exception {
  final String message;

  RoundsFetchException(this.message);

  @override
  String toString() => 'RoundsFetchExpetion: $message';
}
