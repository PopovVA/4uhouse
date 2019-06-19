import 'package:bloc/bloc.dart';
import 'package:user_mobile/src/models/country_phone_data.dart';
import 'package:user_mobile/src/resources/phone_repository.dart';
import 'package:user_mobile/temp/models/country_phone_data_test_2.dart';

import 'phone_event.dart';
import 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc(this.repository);

  PhoneRepository repository;

  @override
  PhoneState get initialState => PhoneUninitialized();

  @override
  Stream<PhoneState> mapEventToState(PhoneEvent event) async* {
    if (event is PhoneCountriesDataRequested) {
      yield PhoneLoading();
      try {
        final List<dynamic> waitList = await Future.wait(<Future<dynamic>>[
          repository.getCountriesPhoneData(),
          repository.getCountryByIp(),
        ]);

        final CountryPhoneDataResponse countryPhoneDataResponse = waitList[0];
        final List<CountryPhoneData> countryPhoneDataList =
            countryPhoneDataResponse.countryPhonesData;
        final List<CountryPhoneData> topCountryPhoneDataList =
            countryPhoneDataResponse.topCountryPhonesData;
        final int creationDate = countryPhoneDataResponse.creationDate;
        final String countryIdByIp = waitList[1];
        //sortData(countryPhoneDataList, countryIdByIp);
        //sortData(topCountryPhoneDataList, countryIdByIp);
        final CountryPhoneData countryPhoneDataByIp =
            getCountryPhoneDataByIp(countryPhoneDataList, countryIdByIp) != null
                ? getCountryPhoneDataByIp(countryPhoneDataList, countryIdByIp)
                : getCountryPhoneDataByIp(topCountryPhoneDataList, countryIdByIp);
        yield PhoneCountriesDataLoaded(countryPhoneDataList,
            topCountryPhoneDataList, creationDate, countryPhoneDataByIp);
      } catch (error) {
        print('=> PhoneState => $error');
        yield PhoneLoadingError(error: error.toString());
      }
    }
  }

  /* List<CountryPhoneData> sortData(
      List<CountryPhoneData> list, String countryIdByIp) {
    final int index =
        list.indexWhere((CountryPhoneData it) => it.countryId == countryIdByIp);
    if (index != -1) {
      final CountryPhoneData temp = list[index];
      list.removeAt(index);
      list.insert(0, temp);
    }
    return list;
  }*/
  CountryPhoneData getCountryPhoneDataByIp(
      List<CountryPhoneData> list, String countryIdByIp) {
    final int index =
        list.indexWhere((CountryPhoneData it) => it.countryId == countryIdByIp);
    return index != -1 ? list[index] : null;
  }
}
