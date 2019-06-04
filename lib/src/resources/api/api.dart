import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:user_mobile/src/models/errors/auth_error.dart';
import 'package:user_mobile/src/models/errors/no_connection_error.dart';

class Api {
  Future<Exception> inferError(int statusCode) async {
    print('=> inferErrorv $statusCode');
    final bool internet = await checkInternet();
    if (internet) {
      switch (statusCode) {
        case 401:
          return AuthError();
        default:
          return Exception();
      }
    } else {
      print('no internet');
      return NoConnectionError();
    }
  }

  Future<bool> checkInternet() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
