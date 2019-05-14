import 'package:flutter/material.dart';
import 'package:provider_mobile/src/ui/components/common/page_template_maxim.dart';

import './pallete.dart';
import './typography.dart';

class AppMaxim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: accentColor,
        primaryColor: primaryColor,
        textTheme: customTextTheme,
      ),
      home: PageTemplateMaxim(
        title: "Maxim",
      ));
  }
}
