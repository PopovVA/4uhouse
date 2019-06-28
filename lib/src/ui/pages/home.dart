import 'package:flutter/material.dart';

import '../../blocs/auth/auth_bloc.dart' show AuthBloc;
import '../components/drawer/drawer.dart' show DrawerOnly;
import 'screen.dart' show Screen;

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {@required this.authBloc, @required this.route, this.arguments});

  final AuthBloc authBloc;
  final String route;
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    return Screen(
        authBloc: authBloc,
        route: route,
        drawer: DrawerOnly(),
        arguments: arguments);
  }
}
