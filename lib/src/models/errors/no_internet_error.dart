class NoInternetError implements Exception {
  NoInternetError({this.message = 'You\'re offline'});

  String message;

  @override
  String toString() => 'NoInternetError';
}
