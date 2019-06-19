import 'dart:async' show Future;
import 'package:http/http.dart' as http;
import 'package:user_mobile/src/models/location.dart';
import './constants/url.dart' show BASE_URL;
import 'api.dart';

class PhoneApi extends Api {
  final http.Client _client = http.Client();

  Future<dynamic> requestCountriesPhoneData() async {
    try {
      final http.Response response =
          await _client.get('${BASE_URL}auth/country-phones-data');
      if (response.statusCode == 200) {
        return processResponse(response);
      } else if (response.statusCode == 204) {
      } else {
        throw response;
      }
    } catch (error) {
      throw await inferError(error);
    }
  }

  Future<String> countryLookUp() async {
    try {
      final http.Response response = await http.get('http://ip-api.com/json');
      if (response.statusCode == 200) {
        return Location.fromJson(await processResponse(response)).countryCode;
      } else {
        throw response;
      }
    } catch (error) {
      throw await inferError(error);
    }
  }
}
