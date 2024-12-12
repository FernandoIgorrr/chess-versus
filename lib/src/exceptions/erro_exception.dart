class ErroException implements Exception {
  final Error error;
  late String message;
  ErroException(this.error) {
    message = error.toString();
  }

  @override
  String toString() => "ErroException: $message";
}
