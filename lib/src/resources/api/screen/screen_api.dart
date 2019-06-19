import 'dart:async' show Future;
import 'package:meta/meta.dart' show required;

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;

import '../api.dart';
import 'constants/url.dart' show USER_URL, GUEST_URL;

class ScreenApi extends Api {
  final http.Client _client = http.Client();

  static String _getUrl(String token) =>
      Api.isValidToken(token) ? USER_URL : GUEST_URL;

  static Uri _componentUri({
    @required String token,
    @required String route,
    dynamic value,
  }) =>
      value != null
          ? Uri.parse('${_getUrl(token)}$route?value=${value.toString()}')
          : Uri.parse('${_getUrl(token)}$route');

  Future<List<Map<String, dynamic>>> fetchScreen(
      {@required String query, String token}) async {
    try {
      print('===> request: ${_getUrl(token)}$query');
      final http.Response response = await _client
          .get('${_getUrl(token)}$query', headers: Api.makeHeaders(token));

      print(response.body.toString());
      if (response.statusCode == 200) {
        final dynamic json = await processResponse(response);
        return json.cast<Map<String, dynamic>>();
      } else {
        throw response;
      }
    } catch (error) {
      throw await inferError(error);
    }
  }

  Future<Map<String, dynamic>> sendComponentValue({
    @required String query,
    dynamic value,
    String token,
  }) async {
    // Form and send request
    try {
      final http.Response response = await _client.put(
          _componentUri(route: query, value: value, token: token),
          headers: Api.makeHeaders(token));

      // Process response
      if (response.statusCode == 200) {
        return processResponse(response);
      } else {
        throw response;
      }
    } catch (error) {
      throw await inferError(error);
    }
  }

  Future<Map<String, dynamic>> uploadImage(
      {@required String query,
      @required dynamic value,
      @required List<int> jpg,
      String token}) async {
    // Form request
    final http.MultipartRequest request = http.MultipartRequest(
        'PUT', _componentUri(route: query, value: value, token: token));
    final http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'img',
      jpg,
      contentType: MediaType.parse('image/jpeg'),
      filename:
          '${query.substring(query.lastIndexOf('/') + 1)}.jpg', // Id of the item
    );
    request.files.add(multipartFile);
    if ((token is String) && token.isNotEmpty) {
      request.headers['${Api.authHeaderKey}'] = Api.formToken(token);
    }

    // Send and process
    try {
      final http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return processResponse(response);
      } else {
        throw response;
      }
    } catch (error) {
      throw await inferError(error);
    }
  }
}
