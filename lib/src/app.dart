import 'package:flutter/material.dart';

import './pallete.dart';
import './typography.dart';
import './ui/pages/screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4u.house',
      theme: ThemeData(
        accentColor: accentColor,
        primaryColor: primaryColor,
        textTheme: customTextTheme,
      ),
    home: Screen('user/property'),
      onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
          builder: (context) =>
              Screen(settings.name, arguments: settings.arguments)),
    );
  }
}
