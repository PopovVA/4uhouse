import 'package:user_mobile/src/models/errors/auth_error.dart';
import 'package:user_mobile/src/models/errors/no_connection_error.dart';
import '../../constants/errors.dart';

class Api {
  Exception inferError(dynamic error) {
    switch (error) {
      case AUTH_ERROR:
        return AuthError();
      case NO_CONNECTION_ERROR:
        return NoConnectionError();
      default:
        return Exception();
    }
  }
}
