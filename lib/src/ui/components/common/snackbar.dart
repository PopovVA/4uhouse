import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget implements SnackBar {
  const CustomSnackBar(
      {@required this.content,
      this.backgroundColor,
      this.action,
      this.animation});

  @override
  final Widget content;
  @override
  final Color backgroundColor;
  @override
  final SnackBarAction action;

  @override
  Duration get duration => Duration(seconds: 6);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      key: key,
      content: content,
      backgroundColor: backgroundColor,
      action: action,
      duration: duration,
      animation: animation,
    );
  }

  @override
  final Animation<double> animation;

  @override
  SnackBar withAnimation(Animation<double> newAnimation, {Key fallbackKey}) {
    return SnackBar(
      key: key,
      content: content,
      backgroundColor: backgroundColor,
      action: action,
      duration: duration,
      animation: newAnimation,
    );
  }
}