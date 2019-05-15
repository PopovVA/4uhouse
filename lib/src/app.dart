import 'package:flutter/material.dart';
import 'package:provider_mobile/src/ui/pages/screen.dart';
import 'package:provider_mobile/src/utils/route_transition.dart';

import 'pallete.dart';
import 'typography.dart';
import 'ui/pages/home/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4u.house',
      theme: ThemeData(
          accentColor: accentColor,
          primaryColor: primaryColor,
          textTheme: customTextTheme),
      home: HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return SlideRoute(widget: HomePage(),side: 'left');
            break;
          default:
            return SlideRoute(widget: Screen(settings.name));
        }
      },
    );
  }
}
