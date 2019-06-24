import 'dart:async' show Future;
import 'dart:io' show File;

import 'package:image/image.dart' as img;

import '../models/screen/screen_model.dart' show ScreenModel;
import 'api/component_api.dart' show ComponentApi;

class ComponentRepository {
  final ComponentApi componentApi = ComponentApi();

  Future<ScreenModel> sendItemValue(String query, dynamic value,
      {dynamic body, String token}) async {
    Map<String, dynamic> response;
    if (body is File) {
      response = await componentApi.uploadImage(
          query: query,
          value: value,
          token: token,
          jpg: img.encodeJpg(img.decodeImage(body.readAsBytesSync())));
    } else {
      response = await componentApi.sendComponentValue(
          query: query, value: value, token: token);
    }

    return ScreenModel.fromJson(response);
  }
}
