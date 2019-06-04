import 'dart:async' show Completer, Future;
import 'dart:convert' show json, utf8;
import 'package:meta/meta.dart' show required;

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import '../../../constants/errors.dart';
import '../api.dart';
import 'constants/url.dart' show BASE_URL;

class ScreenApi {
  final http.Client client = http.Client();

  static String _formToken(String token) => 'Bearer $token';

  static Uri _componentUri({@required String route, @required dynamic value}) =>
      Uri.parse('$BASE_URL$route?value=${value.toString()}');

  Future<Map<String, dynamic>> fetchScreen(
      {@required String query, String token}) async {
    final http.Response response =
        await client.get('$BASE_URL$query', headers: <String, String>{
      'Authorization': token,
    });

    print(response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    } else if (response.statusCode == 401) {
      throw Api().inferError(AUTH_ERROR);
    } else {
      throw Exception(json.decode(response.body)[0]);
    }
  }

  Future<Map<String, dynamic>> sendComponentValue({
    @required String query,
    @required dynamic value,
    String token,
  }) async {
    // Form and send request
    final Map<String, String> headers =
        ((token is String) && token.isNotEmpty) ??
            <String, String>{
              'Authorization': _formToken(token),
            };
    final http.Response response = await client
        .put(_componentUri(route: query, value: value), headers: headers);

    // Process response
    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    }else if (response.statusCode == 401) {
      throw Api().inferError(AUTH_ERROR);
    } else {
      throw Exception('Failed to save item value.');
    }
  }

  Future<Map<String, dynamic>> uploadImage(
      {@required String query,
      @required dynamic value,
      @required List<int> jpg,
      String token}) async {
    // Form request
    final http.MultipartRequest request =
        http.MultipartRequest('PUT', _componentUri(route: query, value: value));
    final http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'img',
      jpg,
      contentType: MediaType.parse('image/jpeg'),
      filename:
          '${query.substring(query.lastIndexOf('/') + 1)}.jpg', // Id of the item
    );
    request.files.add(multipartFile);
    if ((token is String) && token.isNotEmpty) {
      request.headers['Authorization'] = _formToken(token);
    }

    // Send and process
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final Completer<Object> completer = Completer<Object>();
      response.stream.transform(utf8.decoder).listen((Object value) {
        completer.complete(value);
      });
      final String result = await completer.future;
      return json.decode(result)[0];
    }else if (response.statusCode == 401) {
      throw Api().inferError(AUTH_ERROR);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
