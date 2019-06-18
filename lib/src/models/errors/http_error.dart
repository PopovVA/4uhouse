class HttpError implements Exception {
  HttpError([this.message]);

  final String message;

  @override
  String toString() => message;
}
