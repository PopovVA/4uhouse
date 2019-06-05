import 'dart:async';
import 'dart:convert';
import 'package:user_mobile/src/models/country_phone_data_test.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/country_phone_data.dart';

import 'phone_repository.dart';

class TestPhoneRepository extends PhoneRepository {
  @override
  Future<List<CountryPhoneData>> getCountriesPhoneData() async {
    final String response = await rootBundle.loadString('lib/assets/data.json');
    List<CountryPhoneData> list =
        Autogenerated.fromJson(json.decode(response)).countryPhoneDataList;
    return list;
  }
}
