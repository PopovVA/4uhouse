import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:meta/meta.dart' show required;

import 'blocs/auth/auth_bloc.dart' show AuthBloc;
import 'blocs/auth/auth_event.dart' show AppStarted;
import 'constants/navigation.dart' show ROOT_PAGE, LOGIN_PAGE;
import 'pallete.dart' show accentColor, primaryColor;
import 'resources/auth_repository.dart' show AuthRepository;
import 'typography.dart' show customTextTheme;

import 'ui/pages/home.dart' show HomeScreen;
import 'ui/pages/login/phone.dart' show PhoneScreen;
import 'ui/pages/screen.dart' show Screen;

class App extends StatefulWidget {
  const App({@required this.authRepository});

  final AuthRepository authRepository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthBloc authBloc;

  AuthRepository get authRepository => widget.authRepository;

  @override
  void initState() {
    authBloc = AuthBloc(authRepository: authRepository);
    _checkingStorage();
    authBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      bloc: authBloc,
      child: MaterialApp(
        title: '4u.house',
        theme: ThemeData(
            accentColor: accentColor,
            primaryColor: primaryColor,
            textTheme: customTextTheme),
        home: HomeScreen(authBloc: authBloc, route: ROOT_PAGE),
        onGenerateRoute: (RouteSettings settings) {
          final String name = settings.name;
          final Map<String, dynamic> arguments = settings.arguments;
          switch (name) {
            case ROOT_PAGE:
              return MaterialPageRoute<HomeScreen>(
                builder: (BuildContext context) => HomeScreen(
                    authBloc: authBloc, route: name, arguments: arguments),
              );
            case LOGIN_PAGE:
              return MaterialPageRoute<HomeScreen>(
                builder: (BuildContext context) => PhoneScreen(
                  authBloc: authBloc,
                  arguments: arguments,
                ),
              );
            default:
              return MaterialPageRoute<Screen>(
                  builder: (BuildContext context) => Screen(
                      authBloc: authBloc,
                      route: name,
                      arguments: settings.arguments));
          }
        },
      ),
    );
  }

  void _checkingStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool firstRun = prefs.getBool('firstRun');
    if (firstRun == null) {
      authRepository.clearAll();
      prefs.setBool("firstRun", true);
    }
  }

}
