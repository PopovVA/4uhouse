import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../src/models/country_phone_data.dart';
import '../../src/resources/phone_repository.dart';
import '../models/country_phone_data_test_2.dart';

class TestPhoneRepository extends PhoneRepository {

  final String uRl = 'lib/assets/country_phone_data.json';

  @override
  Future<CountryPhoneDataResponse> getCountriesPhoneData() async {
    final String response = await rootBundle.loadString(uRl);
    return CountryPhoneDataResponse.fromJson(json.decode(response));
  }

}
