import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:meta/meta.dart' show required;

import 'blocs/auth/auth_bloc.dart' show AuthBloc;
import 'blocs/auth/auth_event.dart' show AppStarted;

import 'pallete.dart' show accentColor, primaryColor;
import 'resources/auth_repository.dart' show AuthRepository;
import 'typography.dart' show customTextTheme;
import 'ui/pages/home/home.dart' show HomeScreen;

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
        home: const HomeScreen(route: '/property'),
        onGenerateRoute: (RouteSettings settings) {
          final String name = settings.name;
          switch (name) {
            case '/':
            case '/property':
              return MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    HomeScreen(route: name, arguments: settings.arguments),
              );
            default:
              return MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      HomeScreen(route: name, arguments: settings.arguments));
          }
        },
      ),
    );
  }
}
