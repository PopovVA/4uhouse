import 'dart:async';

import 'screen_api_provider.dart';
import '../models/screen_model.dart';

class Repository {
  final screenApiProvider = ScreenApiProvider();

  Future<ScreenModel> fetchScreen(String route) =>
      screenApiProvider.fetchScreen(route);
  Future<ScreenModel> sendItemValue(String route, dynamic value,
      {dynamic body, String contentType}) {
    return screenApiProvider.sendItemValue(route, value, body: body);
  }
}

final repository = Repository();
