import 'dart:async' show Future;
import 'package:http/http.dart' as http;
import '../api/screen_api/constants/url.dart' show BASE_URL;
import 'api.dart';

class PhoneApi extends Api {
  Future<List<Map<String, dynamic>>> requestCountriesPhoneData() async {
    try {
      final http.Response response =
          await http.Client().get('${BASE_URL}accounts/country-phones-data');
      if (response.statusCode == 200) {
        return processResponse(response);
      } else {
        throw inferError(response: response);
      }
    } catch (error) {
      throw inferError(error: error);
    }
  }
}
