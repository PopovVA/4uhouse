import 'package:http/http.dart' as http;
import 'package:user_mobile/src/models/errors/auth_error.dart';
import 'package:user_mobile/src/models/errors/no_connection_error.dart';
import '../../constants/errors.dart';

class Api {
  Exception inferError(http.Response response) {
    switch (response.statusCode) {
      case 401:
        return AuthError();
      default:
        return Exception();
    }
  }
}
