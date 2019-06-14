import 'dart:async' show Completer, Future;
import 'dart:convert' show json, utf8;
import 'dart:io' show SocketException;
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart'
    show Connectivity, ConnectivityResult;

import '../../models/errors/auth_error.dart' show AuthError;
import '../../models/errors/connection_error.dart' show ConnectionError;
import '../../models/errors/no_internet_error.dart' show NoInternetError;

class Api {
  Future<dynamic> inferError(dynamic object) async {
    if (object is SocketException) {
      final bool internet = await _checkInternet();
      if (internet) {
        return ConnectionError();
      } else {
        return NoInternetError();
      }
    } else if (object is http.BaseResponse) {
      switch (object.statusCode) {
        case 401:
          return AuthError();
        default:
          return Exception();
      }
    }
  }

  Future<dynamic> processResponse(http.BaseResponse response) async {
    if (response is http.Response) {
      return json.decode(response.body);
    } else if (response is http.StreamedResponse) {
      final Completer<Object> completer = Completer<Object>();
      response.stream.transform(utf8.decoder).listen((Object value) {
        completer.complete(value);
      });
      final String result = await completer.future;
      return json.decode(result);
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
