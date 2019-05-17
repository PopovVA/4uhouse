import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import '../../../../models/user_profile.dart';
import '../../../../utils/route_transition.dart';
import '../../../pages/example_page.dart';
import '../../inherited_auth.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InheritedAuth inheritedAuth = InheritedAuth.of(context);
    return inheritedAuth.userProfile != null
        ? Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        UserProfile.fromMap(inheritedAuth.userProfile).name,
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(88, 85, 85, 0.87)),
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
                    UserProfile.fromMap(inheritedAuth.userProfile).email,
                    style:
                        const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.54)),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          UserProfile.fromMap(inheritedAuth.userProfile).phone,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromRGBO(95, 93, 93, 0.87)),
                        ),
                        width: 132,
                      ),
                      IconButton(
                          icon: const Icon(
                            OMIcons.borderColor,
                            color: Color.fromRGBO(218, 218, 218, 1),
                          ),
                          onPressed: () {
                            /* Navigator.pushNamedAndRemoveUntil(context, '/home',
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
