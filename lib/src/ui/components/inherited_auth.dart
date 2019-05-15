import 'package:flutter/material.dart';

class InheritedAuth extends InheritedWidget {
  InheritedAuth(this.userProfile, this.onLogin, this.onLogout);

  Map<String, String> userProfile;
  Function onLogin, onLogout;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
