import 'dart:async';
import 'package:user_mobile/src/models/phone/phone_all_response.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  PhoneApi phoneApi = PhoneApi();

  Future<AllPhoneResponse> getCountriesPhoneData({int creationDate}) async {
    final dynamic data = await phoneApi.requestCountriesPhoneData(creationDate);
    return data;
  }


  Future<String> getCountryByIp() async {
    return await phoneApi.countryLookUp();
  }
}
