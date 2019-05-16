import 'package:flutter/material.dart';

class InheritedAuth extends InheritedWidget {
  InheritedAuth(
  {this.userProfile, this.onLogin, this.onLogout, Key key, Widget child})
      : super(key: key, child: child);

  Map<String, String> userProfile;
  Function onLogin, onLogout;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static InheritedAuth of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedAuth);
  }
}
