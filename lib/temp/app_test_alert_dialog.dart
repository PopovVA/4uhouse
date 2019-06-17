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
                            content: const Text(
                              'There was an error loading data. Please repeat the action',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.541327),
                                fontSize: 16,
                              ),
                            ),
                            actions: <Widget>[
                              InkWell(
                                  onTap: () {
                                    print('Ok button tapped');
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Color.fromRGBO(55, 180, 188, 1),
                                      fontSize: 16,
                                    ),
                                  ))
                            ],
                          );
                          /* return AlertDialog(
                            title: Text("Create Transaction"),
                            content: Text('KKjkljkjlkk'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );*/
                        });
                  }),
            );
          }),
        ));
  }
}
