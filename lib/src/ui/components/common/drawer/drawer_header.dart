import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider_mobile/src/models/user_profile.dart';
import 'package:provider_mobile/src/ui/pages/example_page.dart';
import 'package:provider_mobile/src/utils/route_transition.dart';

class Header extends StatelessWidget {
  // ignore: avoid_unused_constructor_parameters
  Header({Map<String, String> userProfile});

  Map<String, String> userProfile;

  UserProfile user = UserProfile(
      name: "Roman", email: "rom12@gmail.com", phone: "89160001122");

  @override
  Widget build(BuildContext context) {
    userProfile = user.toMap();
    return userProfile != null
        ? Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: const Color.fromRGBO(88, 85, 85, 0.87)),
                      ),
                      IconButton(
                          icon: const Icon(
                            OMIcons.close,
                            color: Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                  Text(
                    user.email,
                    style:
                        TextStyle(color: const Color.fromRGBO(0, 0, 0, 0.54)),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          user.phone,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: const Color.fromRGBO(95, 93, 93, 0.87)),
                        ),
                        width: 132,
                      ),
                      IconButton(
                          icon: const Icon(
                            OMIcons.borderColor,
                            color: Color.fromRGBO(218, 218, 218, 1),
                          ),
                          onPressed: () {
                            /*Navigator.pushNamedAndRemoveUntil(context, '/home',
                                (Route<dynamic> route) => false);*/
                            Navigator.push(
                                context,
                                SlideRoute(
                                    widget: ExamplePage(), side: 'left'));
                          })
                    ],
                  ),
                  Divider(
                    color: const Color.fromRGBO(66, 65, 65, 0.38),
                  ),
                ]),
          )
        : Container();
  }
}
