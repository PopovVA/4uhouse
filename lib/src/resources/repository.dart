import 'dart:async';
import '../models/screen_model.dart';
import 'screen_api_provider.dart';


class Repository {
  final ScreenApiProvider screenApiProvider = ScreenApiProvider();

  Future<ScreenModel> fetchScreen(String route) =>
      screenApiProvider.fetchScreen(route);
  Future<ScreenModel> sendItemValue(String route, dynamic value,
      {dynamic body, String contentType}) {
    return screenApiProvider.sendItemValue(route, value, body: body);
  }
}

final Repository repository = Repository();
