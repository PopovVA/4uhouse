import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_mobile/src/models/error.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../api/screen_api/constants/url.dart' show BASE_URL;


class PhoneApi {
  Future<List<Map<String, dynamic>>> requestCountriesPhoneData() async {
    final String response =
        await rootBundle.loadString('lib/temp/country_data.json');
    if (response.isNotEmpty) {
      print(json.decode(response));
      return json.decode(response);
    } else {
      throw Exception(ErrorMessage.fromJson(json.decode(response)));
    }
  }
}
