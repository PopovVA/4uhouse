import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class SubmitPhoneTapped extends LoginEvent {
  SubmitPhoneTapped(this.phone);

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

class ResendOtpTapped extends LoginEvent {
  ResendOtpTapped(this.phone);

  final String phone;

  @override
  String toString() => 'ResendOtpTapped';
}

class CodeEnteringCanceled extends LoginEvent {
  CodeEnteringCanceled(this.phone);

  final String phone;

  @override
  String toString() => 'CodeEnteringCanceled';
}
