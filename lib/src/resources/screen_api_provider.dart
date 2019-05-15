import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;

import '../constants/api.dart' show BASE_URL;
import '../models/screen_model.dart';
import '../utils/type_check.dart' show isNotNullableString;

//String token =
//    'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJNUFpBRFVNUHh0N0tyUDBIZDBIQjlIbnl2MTR0Rk9uckdlb3dfaEstWEtFIn0.eyJqdGkiOiIwY2Y4NGZiYi01NWY3LTRkYTUtYmNlMy1hOTkxMzFkNjBjZmIiLCJleHAiOjE1NTgxNTk2NjQsIm5iZiI6MCwiaWF0IjoxNTU3NzI3NjY0LCJpc3MiOiJodHRwczovL2Rldi5hdXRoLjR1LmhvdXNlL2F1dGgvcmVhbG1zLzR1aG91c2UiLCJzdWIiOiIyMTU0YzdjMS05OTU2LTRmMTUtYmZkZS0yZWMyZjQ0YmRmMjEiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJwcm92aWRlci1tb2JpbGUiLCJhdXRoX3RpbWUiOjAsInNlc3Npb25fc3RhdGUiOiI1NTUxMmRmZS0zYzY2LTQ4ODUtYjhlOS0zNjExZjMyMTQyY2EiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJ1c2VyIl19LCJzY29wZSI6ImVtYWlsIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicHJlZmVycmVkX3VzZXJuYW1lIjoianVsaWF0dWttYWNoZXZhQG1haWwucnUiLCJlbWFpbCI6Imp1bGlhdHVrbWFjaGV2YUBtYWlsLnJ1In0.SAnYLIPjiA6XTEzW-6NTPA2YKM6vlGN22_w2clAS8SDhgPnd_lKImCAUAVgWJQJkzCbBFRfMoXyHDXY1gpVRiLH9D-qFY_g1wI9LAPVgLbxvhrKQxzVpw3Iu1cpLqxoXHveEMzxyrV94dIw8MFbT6hHs5T1GjvH5-qtJTGHH0HsvDszl86FiHBfyj67vM0VXq1TVQ_vtnhwW1sDz09eVcMURiHSGITBrh3P8RRHyttgz8dHNfi8roPTy0mub2gLRZWTUuBxwbhHo2FWR0tnPiYklabJ4zDb813lJLvPiNS0E24tBif4CJVvN-WRd5XtlBAfHLBg3O2xL_QDE2rZ7Xw';

class Token {
  String _token;

  set value(String t) {
    if (t != null && t.length > 0) {
      _token = t;
    }
  }

  String get value => 'Bearer $_token';
}

Token token = Token();

Map<String, dynamic> errorScreen(String message, {String title = 'Error'}) {
  return {
    'value': title,
    'components': [
      {
        'component': 'item',
        'id': 'fail_item',
        'value': message,
        'typeValue': '??',
        'isInput': false,
        'isTransition': false,
      }
    ]
  };
}

class ScreenApiProvider {
  http.Client client = http.Client();

  Future<ScreenModel> fetchScreen(String route) async {
    print("entered $route");
    final query = isNotNullableString(route)
        ? '$BASE_URL$route'
        : '$BASE_URL\\myProperty';
    print('---> query: ${query}');

    print('===> token: ${token.value}');
    final response = await client.get(query, headers: {
      'Authorization': token.value,
    });
    print(response.body.toString());
    print('===> response.statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      return ScreenModel.fromJson(json.decode(response.body)[0]);
    } else {
      return ScreenModel.fromJson(errorScreen('${response.body.toString()}',
          title: response.statusCode.toString()));
    }
  }

  Future<ScreenModel> sendItemValue(String route, dynamic value,
      {dynamic body}) async {
    final Uri uri = Uri.parse('$BASE_URL$route?value=${value.toString()}');
    print('---> query: $uri');
    if (body is File) {
      img.Image imageTmp = img.decodeImage(body.readAsBytesSync());
      var request = http.MultipartRequest('PUT', uri);
      var multipartFile = new http.MultipartFile.fromBytes(
        'img',
        img.encodeJpg(imageTmp),
        contentType: MediaType.parse('image/jpeg'),
        filename:
            '${route.substring(route.lastIndexOf('/') + 1)}.jpg', // Id of the item
      );
      request.files.add(multipartFile);
      request.headers['Authorization'] = token.value;
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Completer completer = Completer();
        response.stream.transform(utf8.decoder).listen((value) {
          completer.complete(value);
        });
        String result = await completer.future;
        return ScreenModel.fromJson(json.decode(result)[0]);
      } else {
        throw Exception('Failed to upload image.');
      }
    } else {
      http.Response response = await client.put(uri, headers: {
        'Authorization': token.value,
      });
      if (response.statusCode == 200) {
        return ScreenModel.fromJson(json.decode(response.body)[0]);
      } else {
        throw Exception('Failed to save item value.');
      }
    }
  }
}
