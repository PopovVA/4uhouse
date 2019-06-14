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
        final List<CountryPhoneData> data = await Future.wait(<Future<dynamic>>[
          repository.getCountriesPhoneData(),
          repository.getCountryByIp()
        ]).then((List<dynamic> waitList) {
          waitList[0].sort((CountryPhoneData a, CountryPhoneData b) {
            if (a.countryId == waitList[1]) {
              return -1;
            }
            if (b.countryId == waitList[1]) {
              return 1;
            }
            return a.countryId.compareTo(b.countryId);
          });
          return waitList[0];
        });

        yield PhoneCountriesDataLoaded(data);
      } catch (error) {
        print('=> PhoneState => $error');
        yield PhoneLoadingError(error: error.toString());
      }
    }
  }
}
