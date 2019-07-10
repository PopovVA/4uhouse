import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable, required;

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class OtpRequested extends LoginEvent {
  OtpRequested({@required this.phoneCountryId,
    @required this.code,
    @required this.phoneNumber})
      : super(<dynamic>[code, code, phoneNumber]);

  final String phoneCountryId;
  final int code;
  final String phoneNumber;

  @override
  String toString() => 'OtpRequested';
}

class SubmitCodeTapped extends LoginEvent {
  SubmitCodeTapped({@required this.phoneNumber, @required this.otp})
      : super(<dynamic>[phoneNumber, otp]);

  final String phoneNumber;
  final String otp;

  @override
  String toString() => 'SubmitCodeTapped';
}

class CodeEnteringCanceled extends LoginEvent {
  @override
  String toString() => 'CodeEnteringCanceled';
}
