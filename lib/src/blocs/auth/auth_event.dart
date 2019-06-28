import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable, required;

import '../../models/auth/user_model.dart' show UserModel;

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class UserLoggedIn extends AuthEvent {
  @override
  String toString() => 'LogoutButtonPressed';
}

class LogoutButtonPressed extends AuthEvent {
  @override
  String toString() => 'LogoutButtonPressed';
}

class RefreshTokenFailed extends AuthEvent {
  @override
  String toString() => 'RefreshTokenFailed';
}
