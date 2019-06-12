import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;
import 'package:user_mobile/src/models/country_phone_data.dart';

@immutable
abstract class PhoneState extends Equatable {
  PhoneState([List<dynamic> props = const <dynamic>[]]) : super(props);

  @override
  String toString();
}

class PhoneUninitialized extends PhoneState {
  @override
  String toString() => 'PhoneUninitialized';
}

class PhoneLoading extends PhoneState {
  @override
  String toString() => 'PhoneLoading';
}

class PhoneCountriesDataLoaded extends PhoneState {
  PhoneCountriesDataLoaded(this.data);

  final List<CountryPhoneData> data;

  @override
  String toString() => 'PhoneCountriesDataLoaded';
}

class PhoneLoadingError extends PhoneState {

  PhoneLoadingError({this.error});

  final String error;

  @override
  String toString() => error;
}
