import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable, required;

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class OtpRequested extends LoginEvent {
  OtpRequested({@required this.countryId,
    @required this.code,
    @required this.number})
      : super(<dynamic>[code, code, number]);

  final String countryId;
  final int code;
  final String number;

  @override
  String toString() => 'OtpRequested';
}

class SubmitCodeTapped extends LoginEvent {
  SubmitCodeTapped(
      {@required this.number, @required this.code, @required this.otp})
      : super(<dynamic>[number, code, otp]);

  final String number;
  final int code;
  final String otp;

  @override
  String toString() => 'SubmitCodeTapped';
}

class CodeEnteringCanceled extends LoginEvent {
  @override
  String toString() => 'CodeEnteringCanceled';
}
