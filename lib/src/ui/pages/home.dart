import 'package:flutter/material.dart';
import '../components/drawer/drawer.dart' show DrawerOnly;
import 'screen.dart' show Screen;

class HomeScreen extends StatelessWidget {
  const HomeScreen({@required this.route, this.arguments});

  final String route;
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    return Screen(route, drawer: DrawerOnly(), arguments: arguments);
  }
}
