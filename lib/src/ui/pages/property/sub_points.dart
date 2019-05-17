import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubPoint extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SubPoint(this._text);

  String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child:const  Icon(Icons.done, color: Color.fromRGBO(115, 115, 115, 0.54)),
        ),
        Container(
          padding: const EdgeInsets.only(left: 11),
          child: Text(_text,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                fontStyle: FontStyle.normal,
                color: Color.fromRGBO(115, 115, 115, 1.0),
              )),
        )
      ],
    ));
  }
}
