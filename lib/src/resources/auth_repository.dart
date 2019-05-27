import 'dart:async' show Future;
import 'dart:convert' show base64, json, utf8;
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:meta/meta.dart' show required;
import 'package:flutter_appauth/flutter_appauth.dart'
    show AuthorizationTokenResponse, TokenResponse;

import '../models/user_profile.dart' show UserProfile;
import 'api/auth_api.dart' show AuthApi;
import 'services/secure_storage.dart' show SecureStorageService;

class AuthRepository {
  final AuthApi _authApi = AuthApi();
  final SecureStorageService _storage = SecureStorageService();

  Future<String> get accessToken async => await _storage.read(key: _access);

  Future<String> get refreshToken async => await _storage.read(key: _refresh);

  Future<String> get idToken async => await _storage.read(key: _id);

  static const String _access = 'accessToken';
  static const String _refresh = 'refreshToken';
  static const String _id = 'idToken';
  static const String _userProfile = 'userProfile';
  static const String _verifier = 'verifier';

  /* Auth operations */
  Future<AuthorizationTokenResponse> login() {
    return _authApi.login();
  }

  Future<UserProfile> loadUserProfile({@required String accessToken}) async {
    if (accessToken is String && accessToken.isNotEmpty) {
      final Map<String, dynamic> decodedUserProfile =
          await _authApi.loadUserProfile(accessToken: accessToken);
      return UserProfile.fromJson(decodedUserProfile);
    }

    throw Exception(
        'auth_repository loadUserProfile: accessToken is not specified.');
  }

  Future<Map<String, dynamic>> logout(
      {@required String accessToken, @required String refreshToken}) async {
    if ((accessToken is String && accessToken.isNotEmpty) &&
        (refreshToken is String && refreshToken.isNotEmpty)) {
      return _authApi.logout(
          accessToken: accessToken, refreshToken: refreshToken);
    }

    throw Exception(
        'auth_repository logout: No access or/and refresh token is not specified.');
  }

  Future<TokenResponse> refresh({@required String refreshToken}) async {
    if (refreshToken is String && refreshToken.isNotEmpty) {
      return _authApi.refresh(refreshToken: refreshToken);
    }

    throw Exception('auth_repository refresh: no refreshToken specified.');
  }

  /* Storage */
  Future<void> storeTokens({@required TokenResponse tokenResponse}) async {
    await _storage.write(key: _access, value: tokenResponse.accessToken);
    await _storage.write(key: _refresh, value: tokenResponse.refreshToken);
    await _storage.write(key: _id, value: tokenResponse.idToken);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> storeCredentials({@required UserProfile userProfile}) async {
    await _storage.write(key: _userProfile, value: json.encode(userProfile));
  }

  Future<void> clearCredentials() async {
    await _storage.delete(key: _userProfile);
  }

  Future<String> generatePkce() async {
    //Code Verifier
    final Random random = Random.secure();
    final List<int> bytes = List<int>.generate(32, (_) => random.nextInt(100));
    final String verifier = base64.encode(bytes);
    putData(_verifier, verifier);
    //Code challenge
    final List<int> bytesVerifier = verifier.codeUnits;
    final List<int> digest = sha256.convert(bytesVerifier).bytes;
    final String challenge = base64.encode(digest);
    return challenge;
  }

  Future<String> readCodeVerifier() async {
    final String verifier = await getData(_verifier);
    return verifier;
  }

  Future<void> putData(String key, String text) async {
    await _storage.write(key: key, value: text);
  }

  Future<String> getData(String key) async {
    return await _storage.read(key: key);
  }
}
