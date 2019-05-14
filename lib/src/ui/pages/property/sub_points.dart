import 'package:flutter/material.dart';

class SubPoint extends StatelessWidget {
  SubPoint(this._text);

  String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.done, color: Color.fromRGBO(115, 115, 115, 0.54)),
            ),
            Container(
              padding: EdgeInsets.only(left: 11),
              child: Text(_text,
                  style: TextStyle(
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
