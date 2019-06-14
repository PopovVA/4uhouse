import 'package:flutter/material.dart';
import 'package:meta/meta.dart' show immutable;

import '../../../typography.dart' show DISABLED_COLOR;

@immutable
class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {this.title, this.content, this.onOk, this.onCancel});

  final String title;
  final String content;
  final Function onOk;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: const Color(0xffeeeeee),
        title: title is String ? Text(title) : null,
        titleTextStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Color(0xde000000)),
        content: content is String ? Text(content) : null,
        contentTextStyle:
            const TextStyle(fontSize: 16.0, color: Color(0x8a000000)),
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        actions: <Widget>[
          if (onCancel is Function)
            FlatButton(
              textColor: DISABLED_COLOR,
              child: const Text('CANCEL'),
              onPressed: onCancel,
            ),
          if (onOk is Function)
            FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: const Text('OK'),
                onPressed: onOk),
        ]);
  }
}
