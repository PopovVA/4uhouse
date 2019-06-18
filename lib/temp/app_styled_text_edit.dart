import 'package:flutter/material.dart';

import '../src/pallete.dart';
import '../src/typography.dart';
import '../src/ui/components/styled/styled_text_field.dart';
import 'styled_text_controler.dart';

class AppStyledText extends StatefulWidget {
  @override
  State createState() => AppStyledTextState();
}

class AppStyledTextState extends State<AppStyledText> {
  final int maxLength = 4;
  final TextEditingController _controller = StyledTextController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '4u.house',
        theme: ThemeData(
          accentColor: accentColor,
          primaryColor: primaryColor,
          textTheme: customTextTheme,
        ),
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6),
            child: StyledTextField(
              autofocus: true,
              borderColor: _controller.text.length != maxLength
                  ? Colors.redAccent
                  : Theme.of(context).primaryColor,
              controller: _controller,
              textAlign: TextAlign.center,
              // maxLength: maxLength,
              //keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ));
  }
}
