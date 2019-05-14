import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PropertyInfo extends StatelessWidget {
  PropertyInfo({this.renta, this.sale});

  String renta;
  String sale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 110,
          height: 66,
          color: Color.fromRGBO(227, 227, 227, 1),
          child: Container(
              width: 5,
              height: 5,
              child: SvgPicture.asset('lib/src/assets/photo.svg')),
        ),
        Container(
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(renta),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                ),
                Text(sale)
              ],
            ),
            Padding(
                child: Text('Property data will be here', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color.fromRGBO(0, 0, 0, 0.87))),
                padding: EdgeInsets.only(right: 27.0, top: 6.0)),
          ]),
        )
      ],
    );
  }
}
