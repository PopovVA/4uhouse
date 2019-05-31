import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  List<CountryPhoneData> list;

  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    list.add(CountryPhoneData.fromJson(
        await PhoneApi().requestCountriesPhoneData()));
    return list;
  }
}
