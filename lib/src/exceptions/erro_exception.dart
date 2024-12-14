class ErroException implements Exception {
  final Error error;
  late String message;
  ErroException(this.error, this.message) {
    message = '$message\n Error:$error';
  }

  @override
  String toString() => "ErroException: $message";
}
