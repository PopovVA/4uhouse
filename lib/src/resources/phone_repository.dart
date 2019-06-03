import 'dart:async';
import '../models/country_phone_data.dart';
import 'api/phone_api.dart';

class PhoneRepository {
  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    return await PhoneApi().requestCountriesPhoneData();
  }
}
