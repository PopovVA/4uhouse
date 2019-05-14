import 'package:flutter/material.dart';

class MainPoint extends StatelessWidget {
  MainPoint(this._text, this._number);

  String _text;
  int _number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(children: <Widget>[
        Container(
          padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
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
                child: Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      _text,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          color: Color.fromRGBO(115, 115, 115, 0.87)),
                    )))),
      ]),
    );
  }
}
