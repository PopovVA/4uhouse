import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart' show Bloc, BlocDelegate, BlocSupervisor;

import 'src/app.dart' show App;
import 'src/resources/auth_repository.dart' show AuthRepository;
//import 'temp/app_old.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onError(
      Bloc<dynamic, dynamic> bloc, Object error, StackTrace stacktrace) {
    print('bloc error: $error');
    print('===> error.runtimeType: ${error.runtimeType}');
    super.onError(bloc, error, stacktrace);
  }
}

void main() {
//  debugPaintSizeEnabled = true;
final str = 'user/property/15';
  final test = str.substring(0, str.lastIndexOf('/'));
print('===> test: ${test}');
  BlocSupervisor().delegate = AppBlocDelegate();
  runApp(App(authRepository: AuthRepository()));
  //runApp(AppScreens());
}
