import 'package:bloc/bloc.dart';
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
    final List<CountryPhoneData> listCountryPhoneData = <CountryPhoneData>[];
    if (event is PhoneCountriesDataRequested) {
      yield PhoneLoading();
      try {
        final List<dynamic> waitList = await Future.wait(<Future<dynamic>>[
          repository.getCountriesPhoneData(
              creationDate: getCreationDate(currentState)),
          repository.getCountryByIp(),
        ]);
        final AllPhoneResponse countryPhoneDataResponse = waitList[0];
        final List<CountryPhoneData> countryPhoneDataList =
            countryPhoneDataResponse.countryPhonesData;
        final List<CountryPhoneData> topCountryPhoneDataList =
            countryPhoneDataResponse.topCountryPhonesData;
        final int creationDate = countryPhoneDataResponse.creationDate;
        final String countryIdByIp = waitList[1];

        final CountryPhoneData countryPhoneByIp =
            getCountryPhoneDataByIp(countryPhoneDataList, countryIdByIp);
        CountryPhoneData countryPhoneDataByIp = countryPhoneByIp != null
            ? countryPhoneByIp
            : getCountryPhoneDataByIp(topCountryPhoneDataList, countryIdByIp);
        if (countryPhoneByIp == null && listCountryPhoneData.isNotEmpty)
          countryPhoneDataByIp =
              listCountryPhoneData[listCountryPhoneData.length - 1];

        listCountryPhoneData.add(countryPhoneDataByIp);
        yield PhoneCountriesDataLoaded(
            countryPhoneDataList,
            topCountryPhoneDataList,
            creationDate,
            listCountryPhoneData[listCountryPhoneData.length - 1]);
      } catch (error) {
        print('=> phone bloc error => $error');
        yield PhoneLoadingError(error: error.toString());
      }
    }
  }

  CountryPhoneData getCountryPhoneDataByIp(
      List<CountryPhoneData> list, String countryIdByIp) {
    final int index =
        list.indexWhere((CountryPhoneData it) => it.countryId == countryIdByIp);
    return index != -1 ? list[index] : null;
  }

  int getCreationDate(PhoneState currentState) {
    if (currentState is PhoneCountriesDataLoaded)
      return currentState.creationDate;
    else
      return null;
  }
}
