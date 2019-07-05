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
          padding: const EdgeInsets.only(bottom: 40.0),
          child: ListTile(
            leading: Icon(
              OMIcons.phone,
            ),
            title: Text(
              userProfile.phone,
              style: const TextStyle(
                  fontSize: 16.0, color: Color.fromRGBO(0, 0, 0, 0.87)),
            ),
            trailing: IconButton(
                icon: const Icon(
                  OMIcons.close,
                  color: Color.fromRGBO(0, 0, 0, 0.54),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        Divider(
          color: const Color.fromRGBO(66, 65, 65, 0.38),
        ),
      ]);

    return Container(height: 0, width: 0,);
  }
}
