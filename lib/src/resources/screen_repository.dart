import 'dart:async' show Future;

import '../models/screen/screen_model.dart' show ScreenModel;
import 'package:user_mobile/src/resources/api/screen_api.dart' show ScreenApi;

class ScreenRepository {
  final ScreenApi screenApi = ScreenApi();

  Future<ScreenModel> fetchScreen({String query = '', String token}) async {
    final Map<String, dynamic> response =
        await screenApi.fetchScreen(query: query, token: token);
    return ScreenModel.fromJson(response);
  }
}
