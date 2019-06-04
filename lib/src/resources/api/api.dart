import 'package:connectivity/connectivity.dart';
import 'package:user_mobile/src/models/errors/auth_error.dart';
import 'package:user_mobile/src/models/errors/connection_error.dart';
import 'package:user_mobile/src/models/errors/no_internet_error.dart';

class Api {
  Future<Exception> inferError(int statusCode) async {
    print('=> inferErrorv $statusCode');
    switch (statusCode) {
      case 401:
        return AuthError();
        break;
      case 0:
        final bool internet = await _checkInternet();
        if (internet) {
          print(ConnectionError().message);
          return ConnectionError();
        } else {
          print(NoInternetError().message);
          return NoInternetError();
        }
        break;
      default:
        return Exception();
    }
  }

  Future<bool> _checkInternet() async {
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
