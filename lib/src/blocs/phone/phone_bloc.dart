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
        final List<CountryPhoneData> list =
            await repository.getCountriesPhoneData();
        yield PhoneCountriesDataLoaded(list);
      } catch (error) {
        yield PhoneLoadingError();
      }
    }
  }
}
