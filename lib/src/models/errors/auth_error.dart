class AuthError implements Exception {
  AuthError(this.message);

  final String message;

  @override
  String toString() => 'Connection error';
}
