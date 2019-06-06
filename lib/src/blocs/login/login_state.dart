import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class LoginState extends Equatable {
  LoginState([List<dynamic> props = const <dynamic>[]]) : super(props);

  @override
  String toString();
}

class PhoneEntering extends LoginState {
  @override
  String toString() => 'PhoneEntering';
}

class IsLoading extends LoginState {
  @override
  String toString() => 'isLoading';
}

class OtpSent extends LoginState {
  @override
  String toString() => 'OtpSent';
}

class LoginError extends LoginState {
  @override
  String toString() => 'LoginError';
}

class PhoneError extends LoginError {
  @override
  String toString() => 'PhoneError';
}

class CodeError extends LoginError {
  @override
  String toString() => 'CodeError';
}
