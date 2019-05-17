import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainPoint extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MainPoint(this._text, this._number);

  String _text;
  int _number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const  EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(children: <Widget>[
        Container(
          padding:const  EdgeInsets.all(1.0),
          decoration:const  BoxDecoration(
            color: Color.fromRGBO(115, 115, 115, 1.0),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              child: Text(_number.toString())),
        ),
        Container(
            child: Flexible(
                child: Padding(
                    padding:const  EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      _text,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          color: Color.fromRGBO(115, 115, 115, 0.87)),
                    )))),
      ]),
    );
  }
}
