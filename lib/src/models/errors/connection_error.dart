class ConnectionError implements Exception {
  ConnectionError({this.message = 'Connection error'});

  String message;

  @override
  String toString() => 'ConnectionError';
}
