import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_mobile/src/models/error.dart';
import '../api/screen_api/constants/url.dart' show BASE_URL;
import 'package:flutter/services.dart' show rootBundle;

class PhoneApi {
  Future<List<Map<String, dynamic>>> requestCountriesPhoneData() async {
    //    final http.Response response =
//        await http.Client().get('$BASE_URL/accounts/country-phones-data');
    final String response =
        await rootBundle.loadString('lib/src/temp/country_data.json');
//    if (response.statusCode == 200) {
    if (response.isNotEmpty) {
      return json.decode(response);
    } else {
      throw Exception(ErrorMessage.fromJson(json.decode(response)));
    }
  }
}
