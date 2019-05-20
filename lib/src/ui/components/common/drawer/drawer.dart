import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import '../../inherited_auth.dart';
import 'drawer_header.dart' show Header;

// ignore: must_be_immutable
class DrawerOnly extends StatelessWidget {
  int _selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final InheritedAuth inheritedAuth = InheritedAuth.of(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Header(),
                buildListTile(context, 'Market',
                    icon: const Icon(OMIcons.search), position: 0),
                buildListTile(context, 'Likes',
                    icon: const Icon(OMIcons.favoriteBorder), position: 1),
                buildDivider(),
                buildListTile(
                  context,
                  'Message',
                  icon: const Icon(OMIcons.forum),
                  position: 2,
                ),
                buildListTile(context, 'Meeting',
                    icon: const Icon(OMIcons.supervisorAccount), position: 3),
                buildDivider(),
                buildListTile(context, 'My account',
                    icon: const Icon(OMIcons.accountCircle), position: 3),
                buildListTile(context, 'Settings',
                    icon: const Icon(OMIcons.settings), position: 6),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: <Widget>[
                  buildDivider(),
                  inheritedAuth.onLogout != null
                      ? buildListTile(context, 'Sign out',
                          icon: const Icon(OMIcons.exitToApp),
                          position: 8,
                          onTap: inheritedAuth.onLogout)
                      : buildListTile(context, 'Sign in',
                          icon: const Icon(OMIcons.exitToApp),
                          position: 8,
                          onTap: inheritedAuth.onLogin),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, String title,
      {Icon icon, int position, Function onTap}) {
    return ListTile(
      onTap: () {
        _selectedDrawerIndex = position;
        Navigator.pop(context);
      },
      selected: _selectedDrawerIndex == position,
      dense: true,
      leading: icon,
      title: Text(title),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 15.0),
      child: Divider(
        color: const Color.fromRGBO(66, 65, 65, 0.38),
      ),
    );
  }
}
