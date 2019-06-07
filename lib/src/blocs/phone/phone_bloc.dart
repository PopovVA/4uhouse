import 'package:bloc/bloc.dart';
import 'package:user_mobile/src/models/country_phone_data.dart';
import 'package:user_mobile/src/resources/phone_repository.dart';

import 'phone_event.dart';
import 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc(this.repository);

  PhoneRepository repository;

  @override
  PhoneState get initialState => PhoneUninitialized();

  @override
  Stream<PhoneState> mapEventToState(PhoneEvent event) async* {
    if (event is PhoneInitialized) {
      yield PhoneLoading();
      try {
        final List<CountryPhoneData> data =
            await repository.getCountriesPhoneData();
        final String countryCode = await repository.getCountryByIp();
        data.sort((CountryPhoneData a, CountryPhoneData b) {
          if (a.countryId == countryCode) {
            return -1;
          }
          if (b.countryId == countryCode) {
            return 1;
          }
          return a.countryId.compareTo(b.countryId);
        });
        print(data.length);
        print('Your countryCode is $countryCode');
        yield PhoneCountriesDataLoaded(data);
      } catch (error) {
        print('=> PhoneState => $error');
        yield PhoneLoadingError();
      }
    }
  }
}
