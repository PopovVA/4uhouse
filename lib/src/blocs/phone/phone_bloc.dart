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
    if (event is PhoneCountriesDataRequested) {
      yield PhoneLoading();
      try {
        final List<dynamic> waitList = await Future.wait(<Future<dynamic>>[
          getCountryPhoneData(currentState),
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
        final CountryPhoneData countryPhoneDataByIp = countryPhoneByIp != null
            ? countryPhoneByIp
            : getCountryPhoneDataByIp(topCountryPhoneDataList, countryIdByIp);
        yield PhoneCountriesDataLoaded(countryPhoneDataList,
            topCountryPhoneDataList, creationDate, countryPhoneDataByIp);
      } catch (error) {
        print('=> PhoneState => $error');
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

  Future<AllPhoneResponse> getCountryPhoneData(PhoneState currentState) async {
    if (currentState is PhoneCountriesDataLoaded)
      return repository.getCountriesPhoneData(
          creationDate: currentState.creationDate);
    else if (currentState is PhoneUninitialized)
      return repository.getCountriesPhoneData();
  }
}
