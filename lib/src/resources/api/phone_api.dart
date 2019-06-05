import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/screen_api/constants/url.dart' show BASE_URL;
import 'api.dart';

class PhoneApi extends Api {
  final http.Client _client = http.Client();

  Future<List<Map<String, dynamic>>> requestCountriesPhoneData() async {
    try {
      final http.Response response =
          await _client.put('http://seasonvar.ru/serial-9676-Fors-mazhory-4-sezon.html');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw response;
      }
    } catch (error) {
      throw inferError(error);
    }
  }
}
