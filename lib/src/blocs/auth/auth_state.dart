import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

import '../../models/user_profile.dart' show UserProfile;

@immutable
abstract class AuthState extends Equatable {
  AuthState([List<dynamic> props = const <dynamic>[]]) : super(props);

  @override
  String toString();
}

class AuthUninitialized extends AuthState {
  @override
  String toString() => 'AuthUninitialized';
}

class AuthCheckIfAuthorized extends AuthState {
  @override
  String toString() => 'AuthCheckIfAuthorized';
}

class AuthAuthorized extends AuthState {
  AuthAuthorized([this.userProfile]) : super(<UserProfile>[userProfile]);

  final UserProfile userProfile;

  @override
  String toString() => 'AuthAuthorized';

  UserProfile get usPr => userProfile;
}

class AuthUnauthorized extends AuthState {
  @override
  String toString() => 'AuthUnauthorized';
}

class LoginError extends AuthState {
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
