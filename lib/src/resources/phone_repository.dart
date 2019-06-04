import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  PhoneApi phoneApi = PhoneApi();

  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    List<CountryPhoneData> list;
    final List<Map<String, dynamic>> data =
        await phoneApi.requestCountriesPhoneData();
    data.forEach((Map<String, dynamic> country) {
      list.add(CountryPhoneData.fromJson(country));
    });
    return list;
  }
}
