import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../../../models/auth/user_model.dart' show UserModel;

class Header extends StatelessWidget {
  const Header({this.userProfile});

  final UserModel userProfile;

  @override
  Widget build(BuildContext context) {
    if (userProfile != null)
      return Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 19, bottom: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Icon(
                      OMIcons.phone,
                      color: const Color.fromRGBO(218, 218, 218, 1),
                    ),
                  ),
                  Text(
                    userProfile.phone,
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
        Divider(
          color: const Color.fromRGBO(66, 65, 65, 0.38),
        ),
      ]);

    return Container(
      height: 0,
      width: 0,
    );
  }
}
