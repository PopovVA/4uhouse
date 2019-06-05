import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import '../../models/errors/auth_error.dart';
import '../../models/errors/connection_error.dart';
import '../../models/errors/no_internet_error.dart';

class Api {
  Future<dynamic> inferError(
      {http.BaseResponse response, SocketException error}) async {
    print('=> inferErrorv =>Error is $error');
    if (error is SocketException) {
      final bool internet = await _checkInternet();
      if (internet) {
        print(ConnectionError().toString());
        return ConnectionError();
      } else {
        print(NoInternetError().toString());
        return NoInternetError();
      }
    } else {
      print('=> inferErrorv =>Response.StatusCode is ${response.statusCode}');
      switch (response.statusCode) {
        case 401:
          return AuthError();
          break;
        default:
          if (response is http.Response) {
            return Exception(response.body);
          }
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
      return json.decode(result)[0];
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
