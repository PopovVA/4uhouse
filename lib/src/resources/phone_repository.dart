import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  final PhoneApi phoneApi = PhoneApi();

  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    List<CountryPhoneData> list = <CountryPhoneData>[];
    final List<Map<String, dynamic>> data =
        await phoneApi.requestCountriesPhoneData();
    data.forEach((Map<String, dynamic> counry) {
      list.add(CountryPhoneData.fromJson(counry));
    });
    return list;
  }
}
