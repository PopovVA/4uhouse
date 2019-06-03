import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../src/models/country_phone_data.dart';
import '../api/screen_api/constants/url.dart' show BASE_URL;

class PhoneApi {

  Future<List<CountryPhoneData>> requestCountriesPhoneData() async {
    final http.Response response =
        await http.Client().get('$BASE_URL/accounts/country-phones-data');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body));
    }
  }
}
