import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:meta/meta.dart' show required;

import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart'
    show
        AuthorizationServiceConfiguration,
        AuthorizationTokenRequest,
        AuthorizationTokenResponse,
        FlutterAppAuth,
        TokenRequest,
        TokenResponse;
import 'package:user_mobile/src/constants/errors.dart';

import 'api.dart';

class AuthApi extends Api {
  final FlutterAppAuth _appAuth = FlutterAppAuth();

  // Keycloak details
  final String _clientId = 'user-mobile';

  final String _discoveryUrl =
      'https://dev.auth.4u.house/auth/realms/4uhouse/.well-known/openid-configuration';

  final String _redirectUrl = 'house.a4u.usermobile:/oauthredirect';

  final List<String> _scopes = const <String>[
    'openid',
    'profile',
    'email',
    'offline_access',
  ];

  final AuthorizationServiceConfiguration _serviceConfiguration =
      AuthorizationServiceConfiguration(
          'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/auth',
          'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/token');

  final String _userInfoEndpoint =
      'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/userinfo';

  Future<AuthorizationTokenResponse> login() async {
    return _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _clientId,
        _redirectUrl,
        serviceConfiguration: _serviceConfiguration,
        scopes: _scopes,
      ),
    );
  }

  Future<TokenResponse> refresh({@required String refreshToken}) async =>
      _appAuth.token(TokenRequest(_clientId, _redirectUrl,
          refreshToken: refreshToken,
          discoveryUrl: _discoveryUrl,
          scopes: _scopes));

  Future<void> logout(
      {@required String accessToken, @required String refreshToken}) async {
    final http.Response response = await http.post(
        'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/logout',
        body: <String, String>{
          'client_id': _clientId,
          'refresh_token': refreshToken
        },
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-type': 'application/x-www-form-urlencoded'
        });
    // no response body, do not decode!
    if (response.statusCode != 204) {
      throw inferError(response);
    }
  }

  Future<Map<String, dynamic>> loadUserProfile(
      {@required String accessToken}) async {
    final http.Response response = await http.get(_userInfoEndpoint,
        headers: <String, String>{'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw inferError(response);
    }
  }

  Future<void> requestOtp(
      String phone, String codeChallenge, String deviceId) async {
    final http.Response response = await http.post(
      'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/logout',
      body: <String, String>{
        'codeChallenge': codeChallenge,
        'deviceId': deviceId,
        'phone': phone
      },
    );
    if (response.statusCode != 204) {
      throw inferError(response);
    }
  }
}
