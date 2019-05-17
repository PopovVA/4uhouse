import 'package:flutter/material.dart';

class InheritedAuth extends InheritedWidget {
  InheritedAuth(
      {this.userProfile, this.onLogin, this.onLogout, Key key, Widget child})
      : super(key: key, child: child);

 final  Map<String, String> userProfile;
 final Function onLogin, onLogout;

  @override
  bool updateShouldNotify(InheritedAuth oldWidget) {
    return onLogin != oldWidget.onLogin &&
        onLogout != oldWidget.onLogout &&
        userProfile != oldWidget.userProfile;
  }

  static InheritedAuth of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedAuth);
  }
}
