import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    final List<CountryPhoneData> data = List<CountryPhoneData>();
    data.add(CountryPhoneData.fromJson(
        await PhoneApi().requestCountriesPhoneData()));
    return data;
  }
}
