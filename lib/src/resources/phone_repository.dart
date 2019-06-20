import 'dart:async';
import 'package:user_mobile/src/models/phone/phone_all_response.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  final PhoneApi phoneApi = PhoneApi();

  Future<AllPhoneResponse> getCountriesPhoneData() async {
    final dynamic data = await phoneApi.requestCountriesPhoneData();
    /* final CountryPhoneDataResponse countryPhoneDataResponse =
        CountryPhoneDataResponse.fromJson(data);*/
    return data;
  }

  /* Future<int> getCreationDate() async {
    final dynamic data = await phoneApi.requestCountriesPhoneData();
    return CountryPhoneDataResponse.fromJson(data).creationDate;
  }
*/
  Future<String> getCountryByIp() async {
    return await phoneApi.countryLookUp();
  }
}
