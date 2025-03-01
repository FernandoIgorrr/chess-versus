class LocalStorageKeyNotFoundException implements Exception {
  final String message;

  LocalStorageKeyNotFoundException(this.message);

  @override
  String toString() => 'LocalStorageKeyNotFoundException: $message';
}
