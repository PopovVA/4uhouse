import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;

import '../constants/api.dart' show BASE_URL;
import '../models/screen_model.dart';
import '../utils/type_check.dart' show isNotNullableString;

const token =
    'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJNUFpBRFVNUHh0N0tyUDBIZDBIQjlIbnl2MTR0Rk9uckdlb3dfaEstWEtFIn0.eyJqdGkiOiI4MjIwMDJiYy05Zjg5LTRjMmUtYjkzZS1hY2IwNzY3NzAyNGEiLCJleHAiOjE1NTc2NzEyMzEsIm5iZiI6MCwiaWF0IjoxNTU3MjM5MjMxLCJpc3MiOiJodHRwczovL2Rldi5hdXRoLjR1LmhvdXNlL2F1dGgvcmVhbG1zLzR1aG91c2UiLCJzdWIiOiIyMTU0YzdjMS05OTU2LTRmMTUtYmZkZS0yZWMyZjQ0YmRmMjEiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJwcm92aWRlci1tb2JpbGUiLCJhdXRoX3RpbWUiOjAsInNlc3Npb25fc3RhdGUiOiI4NzBiY2Y1Ny02NWQ5LTQ1N2ItYmVjOC1iMDBhMjhjNzZjOTciLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJ1c2VyIl19LCJzY29wZSI6ImVtYWlsIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicHJlZmVycmVkX3VzZXJuYW1lIjoianVsaWF0dWttYWNoZXZhQG1haWwucnUiLCJlbWFpbCI6Imp1bGlhdHVrbWFjaGV2YUBtYWlsLnJ1In0.VloE1R3NGOhck6_9a35-5Cj-Fko9AXXMDc02eowfs7CWoIL-AgXtlfvJDxPqGWoAwNFcg-DPhTJPyKLjT34JN07q-luKh_cqlFAs_G3DKH6zD0Qd8F0Alvbc2ZWhAhWuvaU8ue3-3kOsUedAEFFFYW96WPURXa0Q2a-0Z_ZTqp49Xh20W6X_2Z5KQrvqaYH0bzrdOZEGMRnWYP9ciMbUCxKqlSbGsAwtA9asLG0d3xB37ybc8NiTgcH7LqJTNewNApgw3NPXxs17YyNAXGq292-eVA6N2RJkjS2HAi2Rh3Zs2SK9yhcNgap4uaSGWpKdMJDrvSl7ymbvZmY3FM1TzA';

Map<String, dynamic> errorScreen(String message) {
  return {
    'value': 'Error',
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

    final response = await client.get(query, headers: {
      'Authorization': token,
    });
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ScreenModel.fromJson(json.decode(response.body)[0]);
    } else {
      return ScreenModel.fromJson(errorScreen('Failed to load screen :('));
    }
  }

  Future<ScreenModel> sendItemValue(String route, dynamic value,
      {dynamic body}) async {
    final Uri uri = Uri.parse('$BASE_URL$route?value=${value.toString()}');
    print('---> query: $uri');
    if (body is File) {
      print('===> body.lengthSync(): ${body.lengthSync()}');
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
      request.headers['Authorization'] = token;
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
        'Authorization': token,
      });
      if (response.statusCode == 200) {
        return ScreenModel.fromJson(json.decode(response.body)[0]);
      } else {
        throw Exception('Failed to save item value.');
      }
    }
  }
}
