import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  PhoneApi phoneApi = PhoneApi();

  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    List<CountryPhoneData> list;
    final List<Map<String, dynamic>> data =
        await phoneApi.requestCountriesPhoneData();
    print(data);
    data.forEach((Map<String, dynamic> counry) {
      list.add(CountryPhoneData.fromJson(counry));
    });
    return list;
  }
}
