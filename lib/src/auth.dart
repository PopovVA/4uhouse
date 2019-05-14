import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';

import 'ui/pages/login.dart' show Login;
import 'app.dart' show App;

import 'resources/screen_api_provider.dart' show token;

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  bool _isLoading = false;
  String _accessToken;
  String _refreshToken;

  // Keycloak details
  final String _clientId = 'provider-mobile';
  final String _redirectUrl = 'house.a4u.providermobile:/oauthredirect';
  final List<String> _scopes = const [
    'openid',
    'profile',
    'email',
    'offline_access',
  ];

  AuthorizationServiceConfiguration _serviceConfiguration =
      AuthorizationServiceConfiguration(
          'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/auth',
          'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/token');

  void setLoadingState() {
    setState(() {
      _isLoading = true;
    });
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    setState(() {
      print('===> response.accessToken: ${response.accessToken}');
      _accessToken = response.accessToken;
      _refreshToken = response.refreshToken;
      token.value = response.accessToken;
    });
  }

  void _logout() async {
    setLoadingState();
    var httpResponse = await http.post(
        'https://dev.auth.4u.house/auth/realms/4uhouse/protocol/openid-connect/logout',
        body: {
          "client_id": _clientId,
          "refresh_token": _refreshToken
        },
        headers: {
          'Authorization': 'Bearer $_accessToken',
          "Content-type": 'application/x-www-form-urlencoded'
        });
    if (httpResponse.statusCode == 204) {
      setState(() {
        _isLoading = false;
        _accessToken = null;
        _refreshToken = null;
      });
      print('setting state after logout');
    } else {
      print(
          'something went wrong: ${httpResponse?.statusCode}, ${httpResponse?.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_accessToken == null) {
      return Login(
        isLoading: _isLoading,
        onLogin: () async {
          setLoadingState();
          var result = await _appAuth.authorizeAndExchangeCode(
            AuthorizationTokenRequest(
              _clientId,
              _redirectUrl,
              serviceConfiguration: _serviceConfiguration,
              scopes: _scopes,
            ),
          );
          if (result != null) {
            _processAuthTokenResponse(result);
          }
        },
        onLogout: _logout,
      );
    }

    return App();
  }
}
