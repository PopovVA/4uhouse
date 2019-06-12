import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'src/app.dart' show App;
import 'src/resources/auth_repository.dart' show AuthRepository;
import 'temp/app_old.dart';

//import 'temp/app_old.dart' show AppScreens;

class AppBlocDelegate extends BlocDelegate {
//  @override
//  void onTransition(Bloc bloc, Transition transition) {
//    super.onTransition(bloc, transition);
//  }

  @override
  void onError(Bloc<dynamic, dynamic> bloc, Object error,
      StackTrace stacktrace) {
    // handle errors here
    print('bloc error: $error');
    super.onError(bloc, error, stacktrace);
  }
}

// ignore: avoid_void_async
void main() async {
//  debugPaintSizeEnabled = true;
  BlocSupervisor().delegate = AppBlocDelegate();
  runApp(AppScreens());
//  runApp(AppScreens());
}
