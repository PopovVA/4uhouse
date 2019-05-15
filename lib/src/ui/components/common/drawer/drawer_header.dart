import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider_mobile/src/ui/pages/example_page.dart';
import 'package:provider_mobile/src/utils/rout_transition.dart';

class HeaderDrawer extends StatelessWidget {
  String name = "Roman";
  String mail = "rom12@gmail.com";
  String number = "89160001122";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(88, 85, 85, 0.87)),
                ),
                IconButton(
                    icon: Icon(
                      OMIcons.close,
                      color: Color.fromRGBO(0, 0, 0, 0.54),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            Text(
              mail,
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.54)),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    number,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromRGBO(95, 93, 93, 0.87)),
                  ),
                  width: 132,
                ),
                IconButton(
                    icon: Icon(
                      OMIcons.borderColor,
                      color: Color.fromRGBO(218, 218, 218, 1),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '2');
                      /* Navigator.push(context,
                          SlideRoute(widget: ExamplePage(), side: "left"));*/
                    })
              ],
            ),
          ]),
    );
  }
}
