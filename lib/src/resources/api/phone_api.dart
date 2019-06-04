import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_mobile/src/constants/errors.dart';
import 'package:user_mobile/src/models/error.dart';
import '../api/screen_api/constants/url.dart' show BASE_URL;
import 'api.dart';

class PhoneApi extends Api{
  final http.Client _client = http.Client();

  Future<List<Map<String, dynamic>>> requestCountriesPhoneData() async {
    final http.Response response =
        await _client.get('$BASE_URL/accounts/country-phones-data');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw inferError(AUTH_ERROR);
    } else {
      throw Exception(ErrorMessage.fromJson(json.decode(response.body)));
    }
  }
}
