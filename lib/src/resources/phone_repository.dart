import 'dart:async';
import '../../temp/models/country_phone_data_test_2.dart';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  final PhoneApi phoneApi = PhoneApi();

  Future<CountryPhoneDataResponse> getCountriesPhoneData() async {
    final dynamic data = await phoneApi.requestCountriesPhoneData();
    final CountryPhoneDataResponse countryPhoneDataResponse =
        CountryPhoneDataResponse.fromJson(data);
    return countryPhoneDataResponse;
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
