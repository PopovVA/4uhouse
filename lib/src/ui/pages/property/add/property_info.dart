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
          color:const  Color.fromRGBO(227, 227, 227, 1),
          child: Container(
              padding:const  EdgeInsets.all(15.0),
              child: SvgPicture.asset('lib/assets/photo.svg')),
        ),
        Container(
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(renta),
                const Padding(
                  padding: EdgeInsets.only(left: 5.0),
                ),
                Text(sale)
              ],
            ),
            Padding(
                child: Text('Property data will be here',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color:const  Color.fromRGBO(0, 0, 0, 0.87))),
                padding:const  EdgeInsets.only(right: 27.0, top: 6.0)),
          ]),
        )
      ],
    );
  }
}
