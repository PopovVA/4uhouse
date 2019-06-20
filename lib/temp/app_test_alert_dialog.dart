import 'package:flutter/material.dart';

import '../src/pallete.dart';
import '../src/typography.dart';
import 'alert_test_dialog.dart';

class AppAlert extends StatelessWidget {
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
          appBar: AppBar(
            title: const Text('Test Alert Dialog'),
          ),
          body: Builder(builder: (BuildContext context) {
            return Center(
              child: RaisedButton(
                  child: const Text('Press'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StyledAlertDialog(
                            content: 'Helootertrehkjhkjhjkhkjhjhjhjkhjkhkjhjkhkjhkjhjkkjjkhjhjkhjkhjkhjhkjhkjhkjhkjhkjhjhhk',
                            onOk: () {
                              Navigator.of(context).pop();
                            },
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  }),
            );
          }),
        ));
  }
}
