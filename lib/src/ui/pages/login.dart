import 'package:flutter/material.dart';

import '../../pallete.dart';
import '../../typography.dart';

import '../components/common/page_template.dart';
import '../components/common/styled_button.dart';

class Login extends StatelessWidget {

const  Login({this.onLogin, this.onLogout, this.isLoading});

  final Function onLogin;
  final Function onLogout;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: accentColor,
        primaryColor: primaryColor,
        textTheme: customTextTheme,
      ),
      home: PageTemplate(
        title: 'Log in',
        padding: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin:const  EdgeInsets.only(bottom: 8.0),
              child: StyledButton(
                loading: isLoading,
                text: 'log in',
                onPressed: onLogin,
              ),
            ),
            StyledButton(
              loading: isLoading,
              text: 'logout',
              onPressed: onLogout,
            ),
          ],
        ),
      ),
    );
  }
}
