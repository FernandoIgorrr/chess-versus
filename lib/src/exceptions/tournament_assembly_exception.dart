class TournamentAssemblyException implements Exception {
  final String message;

  TournamentAssemblyException(this.message);

  @override
  String toString() => 'TournamentAssemblyException: $message';
}
