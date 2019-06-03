import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/screen_api/constants/url.dart' show BASE_URL;

class PhoneApi {
  Future<List<Map<String, dynamic>>> requestCountriesPhoneData() async {
    final http.Response response =
        await http.Client().get('$BASE_URL/accounts/country-phones-data');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body));
    }
  }
}
