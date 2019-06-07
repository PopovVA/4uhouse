import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  final PhoneApi phoneApi = PhoneApi();

  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    final List<CountryPhoneData> list = <CountryPhoneData>[];
    final List<Map<String, dynamic>> data =
        await phoneApi.requestCountriesPhoneData();
    for (Map<String, dynamic> country in data) {
      list.add(CountryPhoneData.fromJson(country));
    }
    return list;
  }
}
