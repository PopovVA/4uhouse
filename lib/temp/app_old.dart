import 'package:flutter/material.dart';
import '../src/pallete.dart';
import '../src/typography.dart';
import '../src/ui/pages/screen.dart';
import '../src/utils/route_transition.dart';

class AppScreens extends StatelessWidget {
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
      onGenerateRoute: (RouteSettings settings) => SlideRoute(
          widget: Screen(settings.name, arguments: settings.arguments),
          side: 'left'),
    );
  }
}
