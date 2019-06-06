import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class OtpRequested extends LoginEvent {
  OtpRequested(this.phone);

  final String phone;

  @override
  String toString() => 'SubmitPhoneTapped';
}


class SubmitCodeTapped extends LoginEvent {
  SubmitCodeTapped(this.phone, this.code);

  final String phone;
  final int code;

  @override
  String toString() => 'SubmitCodeTapped';
}

class CodeEnteringCanceled extends LoginEvent {
  CodeEnteringCanceled(this.phone);

  final String phone;

  @override
  String toString() => 'CodeEnteringCanceled';
}
