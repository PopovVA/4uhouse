import 'dart:async' show Stream, StreamSubscription;

import 'package:flutter/foundation.dart';

import 'package:flutter_appauth/flutter_appauth.dart'
    show AuthorizationTokenResponse, TokenResponse;
import 'package:meta/meta.dart' show required;
import 'package:bloc/bloc.dart' show Bloc;
import 'package:connectivity/connectivity.dart';
import '../../models/user_profile.dart' show UserProfile;
import '../../resources/auth_repository.dart' show AuthRepository;
import 'auth_event.dart'
    show AppStarted, AuthEvent, LoginButtonPressed, LogoutButtonPressed;
import 'auth_state.dart'
    show
        AuthAuthorized,
        AuthCheckIfAuthorized,
        AuthState,
        AuthUnauthorized,
        AuthUninitialized,
        CodeError,
        LoginError,
        PhoneError;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({@required this.authRepository}) : assert(authRepository != null);

  final AuthRepository authRepository;

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState();
    } else if (event is LogoutButtonPressed) {
      yield* _mapLogoutButtonPressedToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    yield AuthCheckIfAuthorized();
    // figure out a status of user authorization (token store check, token validation)
    final String refreshToken = await authRepository.refreshToken;
    if (refreshToken is String && refreshToken.isNotEmpty) {
      try {
        final TokenResponse tokenResponse =
            await authRepository.refresh(refreshToken: refreshToken);
        await authRepository.storeTokens(tokenResponse: tokenResponse);
        final UserProfile userProfile = await _updateUserProfile();
        yield AuthAuthorized(userProfile);
      } catch (error) {
        // TODO(Andrei): show snackbar error
        yield AuthUnauthorized();
        await authRepository.clearAll();
        throw Exception(error);
      }
    } else {
      // no token stored
      yield AuthUnauthorized();
      yield* _mapErrorLoginTap('phone');
    }
  }

  Stream<AuthState> _mapLoginButtonPressedToState() async* {
    try {
      final AuthorizationTokenResponse authorizationTokenResponse =
          await authRepository.login();
      if (authorizationTokenResponse is AuthorizationTokenResponse) {
        authRepository.storeTokens(tokenResponse: authorizationTokenResponse);
        final UserProfile userProfile = await _updateUserProfile();
        yield AuthAuthorized(userProfile);
      }
    } catch (error) {
      // TODO(Andrei): show snackbar error
      throw Exception(error);
    }
  }

  Stream<AuthState> _mapErrorLoginTap(String error) async* {
    LoginError currentState;
    switch (error) {
      case 'phone':
        yield currentState = PhoneError();
        break;
      case 'code':
        yield currentState = CodeError();
        break;
      default:
        yield currentState = LoginError();
    }
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Stream<AuthState> _mapLogoutButtonPressedToState() async* {
    try {
      final String accessToken = await authRepository.accessToken;
      final String refreshToken = await authRepository.refreshToken;
      await authRepository.logout(
          accessToken: accessToken, refreshToken: refreshToken);
      await authRepository.clearAll();
      yield AuthUnauthorized();
    } catch (error) {
      // TODO(Andrei): show snackbar error
      throw Exception(error);
    }
  }

  Future<UserProfile> _updateUserProfile() async {
    final String accessToken = await authRepository.accessToken;
    final UserProfile userProfile =
        await authRepository.loadUserProfile(accessToken: accessToken);
    await authRepository.storeCredentials(userProfile: userProfile);

    return userProfile;
  }
}
