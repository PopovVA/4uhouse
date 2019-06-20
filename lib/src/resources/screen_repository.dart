import 'dart:async' show Future;
import 'dart:io' show File;

import 'package:image/image.dart' as img;

import '../models/screen/screen_model.dart' show ScreenModel;
import 'package:user_mobile/src/resources/api/screen/screen_api.dart' show ScreenApi;

class ScreenRepository {
  final ScreenApi screenApi = ScreenApi();

  Future<ScreenModel> fetchScreen({String query = '', String token}) async {
    final Map<String, dynamic> response =
        await screenApi.fetchScreen(query: query, token: token);
    return ScreenModel.fromJson(response);
  }

  Future<ScreenModel> sendItemValue(String query, dynamic value,
      {dynamic body, String token}) async {
    Map<String, dynamic> response;
    if (body is File) {
      response = await screenApi.uploadImage(
          query: query,
          value: value,
          token: token,
          jpg: img.encodeJpg(img.decodeImage(body.readAsBytesSync())));
    } else {
      response = await screenApi.sendComponentValue(query: query, value: value);
    }

    return ScreenModel.fromJson(response);
  }
}
