import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/phone/country_phone_data.dart';
import '../../models/phone/phone_all_response.dart';
import '../../resources/phone_repository.dart';

import 'phone_event.dart';
import 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc(this.repository);

  PhoneRepository repository;

  @override
  PhoneState get initialState => PhoneUninitialized();

  @override
  Stream<PhoneState> mapEventToState(PhoneEvent event) async* {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    if (event is PhoneCountriesDataRequested) {
      yield PhoneLoading();
      try {
        final List<dynamic> waitList = await Future.wait(<Future<dynamic>>[
          repository.getCountriesPhoneData(
              creationDate: getCreationDate(currentState)),
          repository.getCountryByIp(),
        ]);
        final AllPhoneResponse allPhoneResponse = waitList[0];
        final List<CountryPhoneData> countryPhoneDataList =
            allPhoneResponse.countryPhonesData;
        final List<CountryPhoneData> topCountryPhoneDataList =
            allPhoneResponse.topCountryPhonesData;
        final int creationDate = allPhoneResponse.creationDate;
        final String countryIdByIp = waitList[1];

        CountryPhoneData countryPhoneData = getCountryPhone(
            countryPhoneDataList, topCountryPhoneDataList, countryIdByIp);

        if (countryPhoneData == null) {
          final String countryIdByIp = await storage.read(key: 'countryId');
          countryPhoneData = getCountryPhone(
              countryPhoneDataList, topCountryPhoneDataList, countryIdByIp);
        } else {
          await storage.write(
              key: 'countryId', value: countryPhoneData.countryId);
        }

        yield PhoneCountriesDataLoaded(countryPhoneDataList,
            topCountryPhoneDataList, creationDate, countryPhoneData);
      } catch (error) {
        print('=> phone bloc error => $error');
        yield PhoneLoadingError(error: error.toString());
      }
    }
  }

  CountryPhoneData getCountryPhone(List<CountryPhoneData> countryPhoneDataList,
      List<CountryPhoneData> topCountryPhoneDataList, String countryIdByIp) {
    final CountryPhoneData countryPhoneByIp =
        getCountryPhoneDataByIp(countryPhoneDataList, countryIdByIp);
    return countryPhoneByIp != null
        ? countryPhoneByIp
        : getCountryPhoneDataByIp(topCountryPhoneDataList, countryIdByIp);
  }

  int getCreationDate(PhoneState currentState) {
    if (currentState is PhoneCountriesDataLoaded)
      return currentState.creationDate;
    else
      return null;
  }

  CountryPhoneData getCountryPhoneDataByIp(
      List<CountryPhoneData> list, String countryIdByIp) {
    final int index =
        list.indexWhere((CountryPhoneData it) => it.countryId == countryIdByIp);
    return index != -1 ? list[index] : null;
  }
}
