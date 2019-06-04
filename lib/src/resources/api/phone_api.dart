import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/screen_api/constants/url.dart' show BASE_URL;
import 'api.dart';

class PhoneApi extends Api {
  final http.Client _client = http.Client();

  Future<List<Map<String, dynamic>>> requestCountriesPhoneData() async {
    print('=> requestCountriesPhoneData');
    int statusCode = 0;
    try {
      final http.Response response =
          await _client.get('${BASE_URL}accounts/country-phones-data');
      statusCode = response.statusCode;
      print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (error) {
      print('=> requestCountriesPhoneData => $error');
      throw inferError(statusCode);
    }
  }
}
