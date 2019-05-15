import 'package:rxdart/rxdart.dart';
import 'dart:convert';

import '../resources/repository.dart';
import '../models/screen_model.dart';

class ScreenBloc {
  final _repository = Repository();

  final _screen = PublishSubject<ScreenModel>();
  Observable<ScreenModel> get screen => _screen.stream;

  fetchScreen(String route) async {
    ScreenModel screenModel = await _repository.fetchScreen(route);
    _screen.sink.add(screenModel);
  }

  sendItemValue(String route, dynamic value, {dynamic body}) async {
    ScreenModel screenModel =
        await _repository.sendItemValue(route, value, body: body);
    _screen.sink.add(screenModel);
  }

  dispose() {
    _screen.close();
  }
}

final bloc = ScreenBloc();
