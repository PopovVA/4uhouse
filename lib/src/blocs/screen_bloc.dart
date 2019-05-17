
import 'package:rxdart/rxdart.dart';

import '../models/screen_model.dart';
import '../resources/repository.dart';

class ScreenBloc {
  final Repository _repository = Repository();

  final PublishSubject<ScreenModel> _screen = PublishSubject<ScreenModel>();
  Observable<ScreenModel> get screen => _screen.stream;


 // ignore: avoid_void_async
 void fetchScreen(String route) async {
    final ScreenModel screenModel = await _repository.fetchScreen(route);
    _screen.sink.add(screenModel);
  }


 // ignore: avoid_void_async, always_declare_return_types
 sendItemValue(String route, dynamic value, {dynamic body}) async {
    final ScreenModel screenModel =
        await _repository.sendItemValue(route, value, body: body);
    _screen.sink.add(screenModel);
  }

 void dispose() {
    _screen.close();
  }
}

final ScreenBloc bloc = ScreenBloc();
