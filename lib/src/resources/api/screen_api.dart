import 'dart:async' show Future;
import 'package:meta/meta.dart' show required;

import 'package:http/http.dart' as http;

import 'generic/user_data/user_data.dart' show UserData;

class ScreenApi extends UserData {
  Future<Map<String, dynamic>> fetchScreen(
      {@required String query, String token}) async {
    try {
      print('===> screen request: ${getUrl(token, query)}');
      final http.Response response =
          await client.get(getUrl(token, query), headers: makeHeaders(token));

      print(response.body.toString());
      if (response.statusCode == 200) {
        final dynamic json = await processResponse(response);
        return json;
      } else {
        throw response;
      }
    } catch (error) {
      throw await inferError(error);
    }
  }
}
