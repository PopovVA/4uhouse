import 'dart:async' show Future;
import 'dart:convert' show base64, json, ascii;
import 'dart:math' show Random;

import 'package:crypto/crypto.dart' show sha256;
import 'package:device_info/device_info.dart'
    show AndroidDeviceInfo, DeviceInfoPlugin, IosDeviceInfo;
import 'package:meta/meta.dart' show required;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
import 'package:uuid/uuid.dart' show Uuid;

import '../models/auth/token_response_model.dart' show TokenResponseModel;
import '../models/auth/user_model.dart' show UserModel;
import 'api/auth/auth_api.dart' show AuthApi;
import 'services/secure_storage.dart' show SecureStorageService;

class AuthRepository {
  final AuthApi _authApi = AuthApi();
  final SecureStorageService _storage = SecureStorageService();

  Future<String> get accessToken async => await readData(_access);

  Future<String> get refreshToken async => await readData(_refresh);

  Future<UserModel> get userProfile async => await readCredentials();

  static const String _access = 'accessToken';
  static const String _refresh = 'refreshToken';
  static const String _userProfile = 'userProfile';
  static const String _verifier = 'verifier';
  static const String _appId = 'appId';

  /* Login flow */
  Future<void> getOtp(
      {@required String countryId,
      @required int code,
      @required String number}) async {
    final String appId = await getAppId();
    final String codeChallenge = await _generatePKCE();
    return _authApi.requestOtp(
        codeChallenge: codeChallenge,
        appId: appId,
        countryId: countryId,
        code: code,
        number: number);
  }

  Future<void> login(
      {@required String number,
      @required int code,
      @required String otp}) async {
    final String codeVerifier = await readData(_verifier);
    final String appId = await getAppId();

    if (!(codeVerifier is String && codeVerifier.isNotEmpty)) {
      throw Exception('auth_repository.login: no codeVerifier specified.');
    }

    if (!(deviceId is String && deviceId.isNotEmpty)) {
      throw Exception('auth_repository.login: no deviceId specified.');
    }

    final TokenResponseModel tokenResponse = await _authApi.requestToken(
      number: number,
      code: code,
      otp: otp,
      codeVerifier: codeVerifier,
      appId: appId,
    );

    await _storeTokens(tokenResponse: tokenResponse);
  }

  Future<void> refresh() async {
    final String refreshToken = await readData(_refresh);
    if (refreshToken is String && refreshToken.isNotEmpty) {
      final TokenResponseModel tokenResponse =
          await _authApi.refreshToken(refreshToken: refreshToken);
      await _storeTokens(tokenResponse: tokenResponse);
    } else {
      throw Exception('auth_repository.refresh: no refreshToken specified.');
    }
  }

  /* Login flow helpers */
  String _base64URLEncode(List<int> bytes) {
    return base64
        .encode(bytes)
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '')
        .trim();
  }

  Future<String> _generatePKCE() async {
    // Code Verifier
    final Random random = Random.secure();
    final List<int> bytes = List<int>.generate(32, (_) => random.nextInt(127));

    final String verifier = _base64URLEncode(bytes);
    await storeData(_verifier, verifier);

    // Code challenge
    final List<int> digest = sha256.convert(ascii.encode(verifier)).bytes;
    return _base64URLEncode(digest);
  }

  Future<String> _getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } catch (error) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }
  }

  Future<void> setAppId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String appId = prefs.getString(_appId);
    if (appId == null) {
      clearAll();
      appId = Uuid().v4();
      prefs.setString(_appId, appId);
    }
    print('===> appId: ${appId}');
  }

  Future<String> getAppId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_appId);
  }

  Future<void> _storeTokens(
      {@required TokenResponseModel tokenResponse}) async {
    await storeData(_access, tokenResponse.accessToken);
    await storeData(_refresh, tokenResponse.refreshToken);
  }

  /* Auth operations */
  Future<void> logout() async {
    final String accessToken = await this.accessToken;
    if (!(accessToken is String && accessToken.isNotEmpty)) {
      throw Exception('auth_repository.logout: No access token specified.');
    }

    await _authApi.logout(accessToken: accessToken);
  }

  Future<UserModel> loadUserProfile() async {
    final String accessToken = await this.accessToken;
    if (!(accessToken is String && accessToken.isNotEmpty)) {
      throw Exception(
          'auth_repository.loadUserProfile: accessToken is not specified.');
    }

    final UserModel userProfile =
        await _authApi.loadUserProfile(accessToken: accessToken);
    await storeCredentials(userProfile: userProfile);
    return userProfile;
  }

  /* Storage */
  Future<void> storeData(String key, String text) async {
    await _storage.write(key: key, value: text);
  }

  Future<String> readData(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> storeCredentials({@required UserModel userProfile}) {
    return storeData(_userProfile, json.encode(userProfile.toJson()));
  }

  Future<UserModel> readCredentials() async {
    final String jsonString = await readData(_userProfile);

    if (!(jsonString is String && jsonString.isNotEmpty)) {
      throw Exception(
          'auth_repository.getCredentials: no user profile stored.');
    }

    return UserModel.fromJson(json.decode(jsonString));
  }

  Future<void> clearCredentials() async {
    await _storage.delete(key: _userProfile);
  }
}
