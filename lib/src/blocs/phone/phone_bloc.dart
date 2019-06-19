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
        final int index = countryPhoneDataList
            .indexWhere((CountryPhoneData it) => it.countryId == countryIdByIp);
        if (index != -1) {
          final CountryPhoneData temp = countryPhoneDataList[index];
          countryPhoneDataList.removeAt(index);
          countryPhoneDataList.insert(0, temp);
        }

        yield PhoneCountriesDataLoaded(
            countryPhoneDataList, topCountryPhoneDataList, creationDate);
      } catch (error) {
        print('=> PhoneState => $error');
        yield PhoneLoadingError(error: error.toString());
      }
    }
  }
}
