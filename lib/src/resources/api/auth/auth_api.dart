import 'dart:async' show Future;

import 'package:meta/meta.dart' show required;
import 'package:http/http.dart' as http;

import '../api.dart' show Api;
import 'constants/url.dart' show OAUTH_URL, USER_URL;

class AuthApi extends Api {
  final http.Client client = http.Client();

  static const String _contentType = 'x-www-form-urlencoded';

  // endpoints
  static const String _otpEndpoint = '${OAUTH_URL}otp';
  static const String _tokenEndpoint = '${OAUTH_URL}token';
  static const String _logoutEndpoint = '${USER_URL}logout';
  static const String _userInfoEndpoint = '${USER_URL}userinfo';

  static String _formBodyParametersToString(Map<String, dynamic> parameters) {
    final List<String> formBody = <String>[];

    parameters.forEach((String key, dynamic value) {
      final String encodedKey = Uri.encodeFull(key);
      final String encodedValue = Uri.encodeFull(value);
      formBody.add('$encodedKey=$encodedValue');
    });

    return formBody.join('&');
  }

  static Map<String, String> _makeHeaders({String accessToken}) {
    final Map<String, String> headers = <String, String>{
      'Content-type': _contentType,
    };

    if (accessToken is String && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }

  Future<void> requestOtp(String codeChallenge, String deviceId,
      String countryId, int countryCode, String number) async {
    try {
      final http.Response response = await http.post(
        _otpEndpoint,
        headers: _makeHeaders(),
        body: _formBodyParametersToString(<String, dynamic>{
          'code_challenge': codeChallenge,
          'device_id': deviceId,
          'country_id': countryId,
          'country_code': countryCode,
          'number': number
        }),
      );

      if (response.statusCode != 204) {
        throw response;
      }

    } catch (error) {
      throw inferError(error);
    }
  }

  Future<TokenResponse> refresh({@required String refreshToken}) async =>
      _appAuth.token(TokenRequest(_clientId, _redirectUrl,
          refreshToken: refreshToken,
          discoveryUrl: _discoveryUrl,
          scopes: _scopes));

  Future<void> logout(
      {@required String accessToken, @required String refreshToken}) async {
    try {
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
        throw response;
      }
    } catch (error) {
      throw inferError(error);
    }
  }

  Future<Map<String, dynamic>> loadUserProfile(
      {@required String accessToken}) async {
    try {
      final http.Response response = await http.get(_userInfoEndpoint,
          headers: <String, String>{'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        return processResponse(response);
      } else {
        throw response;
      }
    } catch (error) {
      throw inferError(error);
    }
  }
}
