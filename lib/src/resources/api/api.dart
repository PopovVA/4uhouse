import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:user_mobile/src/models/error.dart';
import '../../models/errors/auth_error.dart';
import '../../models/errors/connection_error.dart';
import '../../models/errors/no_internet_error.dart';

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
          break;
        default:
            return Exception(
                ErrorMessage.fromJson(await processResponse(object)).message);
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
