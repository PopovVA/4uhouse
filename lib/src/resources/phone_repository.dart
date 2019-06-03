import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  PhoneApi phoneApi = PhoneApi();

  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    final List<CountryPhoneData> data = List<CountryPhoneData>();
    data.add(
        CountryPhoneData.fromJson(await phoneApi.requestCountriesPhoneData()));
    return data;
  }
}
