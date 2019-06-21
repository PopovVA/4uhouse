import 'dart:async' show Future;
import 'package:http/http.dart' as http;

import '../../models/location.dart' show Location;
import '../../models/phone/phone_all_response.dart' show AllPhoneResponse;
import './constants/url.dart' show BASE_URL;
import 'generic/api.dart' show Api;

class PhoneApi extends Api {
  Future<dynamic> requestCountriesPhoneData() async {
    try {
      final http.Response response =
          await client.get('${BASE_URL}auth/country-phones-data');
      if (response.statusCode == 200) {
        return AllPhoneResponse.fromJson(await processResponse(response));
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
