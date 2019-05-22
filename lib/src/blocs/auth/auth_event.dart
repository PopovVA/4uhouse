import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class LoginButtonPressed extends AuthEvent {
  @override
  String toString() => 'LoginButtonPressed';
}

class LogoutButtonPressed extends AuthEvent {
  @override
  String toString() => 'LogoutButtonPressed';
}
