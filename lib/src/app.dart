import 'package:flutter/material.dart';
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
        home: HomePage());
  }
}
