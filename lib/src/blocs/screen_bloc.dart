import 'package:rxdart/rxdart.dart' show Observable, PublishSubject;
import 'package:meta/meta.dart' show required;
import 'package:user_mobile/src/models/screen/components/button_model.dart';

import '../models/screen/screen_model.dart' show ScreenModel;
import '../resources/auth_repository.dart' show AuthRepository;
import '../resources/screen_repository.dart' show ScreenRepository;

class ScreenBloc {
  ScreenBloc({@required this.authRepository, @required this.screenRepository});

  final AuthRepository authRepository;
  final ScreenRepository screenRepository;

  final PublishSubject<ScreenModel> _screen = PublishSubject<ScreenModel>();

  Observable<ScreenModel> get screen => _screen.stream;


  Future<String> get token async {
    return authRepository.accessToken;
  }

  Future<void> fetchScreen(String route) async {
    final String token = await this.token;
    if ((token is String) && token.isNotEmpty) {
      final ScreenModel screenModel =
          await screenRepository.fetchScreen(query: route, token: token);
      _screen.sink.add(screenModel);
    } else {
       // TODO(Andrei): show snackbar error
    }
  }

  Future<void> sendItemValue(String route, dynamic value,String typeQuery,
      {dynamic body}) async {
    final String token = await this.token;
    if ((token is String) && token.isNotEmpty) {
      final ScreenModel screenModel =
          await screenRepository.sendItemValue(route, value,typeQuery, body: body,);
      _screen.sink.add(screenModel);
    } else {

      // TODO(Andrei): show snackbar error
    }
  }

  void dispose() {
    _screen.close();
  }
}
