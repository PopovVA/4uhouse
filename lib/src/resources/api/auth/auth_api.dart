import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:meta/meta.dart' show required;

import 'package:http/http.dart' as http;

import '../../../models/auth/token_response_model.dart' show TokenResponseModel;
import '../../../models/auth/user_model.dart' show UserModel;
import '../api.dart' show Api;
import 'constants/url.dart' show OAUTH_URL, USER_URL;

class AuthApi extends Api {
  final http.Client client = http.Client();

  static const String _contentType = 'application/x-www-form-urlencoded';
  static const String clientId = 'user-mobile';

  // endpoints
  static const String _otpEndpoint = '${OAUTH_URL}otp';
  static const String _tokenEndpoint = '${OAUTH_URL}token';
  static const String _logoutEndpoint = '${USER_URL}logout';
  static const String _userInfoEndpoint = '${USER_URL}userinfo';

  static String _encodeMapToUrl(Map<String, dynamic> parameters) {
    final List<String> urlEncodedForm = <String>[];
    parameters.forEach((String key, dynamic value) =>
        urlEncodedForm.add('${Uri.encodeFull(key)}=${Uri.encodeFull(value.toString())}'));

    return urlEncodedForm.join('&');
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

  Future<void> requestOtp(
      {@required String codeChallenge,
      @required String deviceId,
      @required String countryId,
      @required int code,
      @required String number}) async {
    try {
      final http.Response response = await client.post(
        _otpEndpoint,
        headers: _makeHeaders(),
        body: _encodeMapToUrl(<String, dynamic>{
          'code_challenge': codeChallenge,
          'app_id': deviceId,
          'country_id': countryId,
          'country_code': code,
          'number': number
        }),
      );

      print('===> response.statusCode: ${response.statusCode}');
      print('===> response.body: ${response.body}');
      if (response.statusCode != 204) {
        throw response;
      }
    } catch (error) {
      throw await inferError(error);
    }
  }

  Future<TokenResponseModel> requestToken(
      {@required String number,
      @required int code,
      @required String otp,
      @required String codeVerifier,
      @required String deviceId}) async {
    final String phone = '$code$number';
    try {
      final http.Response response = await client.post(
        _tokenEndpoint,
        headers: _makeHeaders(),
        body: _encodeMapToUrl(<String, dynamic>{
          'grant_type': 'otp',
          'client_id': clientId,
          'phone': phone,
          'otp': otp,
          'code_verifier': codeVerifier,
          'app_id': deviceId,
        }),
      );

      print('===> response.statusCode: ${response.statusCode}');
      print('===> response.body: ${response.body}');

      if (response.statusCode != 200) {
        throw response;
      }

      return TokenResponseModel.fromJson(json.decode(response.body));
    } catch (error) {
      throw await inferError(error);
    }
  }

  Future<TokenResponseModel> refreshToken(
      {@required String refreshToken}) async {
    try {
      final http.Response response = await client.post(
        _tokenEndpoint,
        headers: _makeHeaders(),
        body: _encodeMapToUrl(<String, dynamic>{
          'grant_type': 'refresh_token',
          'client_id': clientId,
          'refreshToken': refreshToken,
        }),
      );

      if (response.statusCode != 200) {
        throw response;
      }

      return TokenResponseModel.fromJson(json.decode(response.body));
    } catch (error) {
      throw await inferError(error);
    }
  }

  Future<void> logout({@required String accessToken}) async {
    try {
      final http.Response response = await client.post(
        _logoutEndpoint,
        headers: _makeHeaders(accessToken: accessToken),
      );

      if (response.statusCode != 204) {
        throw response;
      }
    } catch (error) {
      print('===> logout error: ${error.statusCode}');
      print('===> logout error body: ${error.body}');
      throw await inferError(error);
    }
  }

  Future<UserModel> loadUserProfile({@required String accessToken}) async {
    try {
      final http.Response response = await client.get(
        _userInfoEndpoint,
        headers: _makeHeaders(accessToken: accessToken),
      );

      if (response.statusCode != 200) {
        throw response;
      }

      return UserModel.fromJson(json.decode(response.body));
    } catch (error) {
      throw await inferError(error);
    }
  }
}
