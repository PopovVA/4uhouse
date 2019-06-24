import 'dart:async' show Future;
import 'package:meta/meta.dart' show required;

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;

import 'generic/user_data/user_data.dart' show UserData;

class ComponentApi extends UserData {
  Uri _componentUri({
    @required String token,
    @required String route,
    dynamic value,
  }) =>
      value != null
          ? Uri.parse('${getUrl(token, route)}?value=${value.toString()}')
          : Uri.parse(getUrl(token, route));

  Future<Map<String, dynamic>> sendComponentValue({
    @required String query,
    dynamic value,
    String token,
  }) async {
    // Form and send request
    try {
      final http.Response response = await client.put(
          _componentUri(route: query, value: value, token: token),
          headers: makeHeaders(token));

      // Process response
      if (response.statusCode == 200) {
        return processResponse(response);
      } else {
        throw response;
      }
    } catch (error) {
      print('===> await inferError(error): ${await inferError(error)}');
      throw await inferError(error);
    }
  }

  Future<Map<String, dynamic>> uploadImage(
      {@required String query,
      @required dynamic value,
      @required List<int> jpg,
      String token}) async {
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
      request.headers['${authHeaderKey}'] = formToken(token);
    }

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
