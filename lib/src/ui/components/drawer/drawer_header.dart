import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../../../models/auth/user_info.dart' show UserInfo;

class Header extends StatelessWidget {
  const Header({this.userProfile});

  final UserInfo userProfile;

  @override
  Widget build(BuildContext context) {
    if (userProfile?.phone != null)
      return Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 19, bottom: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Icon(
                      OMIcons.phone,
                      color: const Color.fromRGBO(117, 116, 116, 1),
                    ),
                  ),
                  Text(
                    userProfile.phone.number,
                    style: const TextStyle(
                        fontSize: 16.0, color: Color.fromRGBO(0, 0, 0, 0.87)),
                  ),
                ],
              ),
              IconButton(
                  icon: const Icon(
                    OMIcons.close,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
        const Divider(
          color: Color.fromRGBO(66, 65, 65, 0.38),
        ),
      ]);

    return Container(
      height: 0,
      width: 0,
    );
  }
}
