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
            subtitle: '10/1',
            position: 2,
          ),
          buildListTile(context, 'Meeting at the property',
              icon: const Icon(OMIcons.supervisorAccount),
              subtitle: '0',
              position: 3),
          buildDivider(),
          buildListTile(context, 'My property',
              icon: const Icon(OMIcons.image), position: 4),
          buildListTile(context, 'My tasks',
              icon: const Icon(OMIcons.checkBox), position: 5),
          buildDivider(),
          buildListTile(context, 'Settings',
              icon: const Icon(OMIcons.settings), position: 6),
          buildListTile(
            context,
            'Forum',
            icon: const Icon(OMIcons.speakerNotes),
            position: 7,
          ),
          inheritedAuth.onLogout != null
              ? buildListTile(context, 'Log out',
                  icon: const Icon(OMIcons.exitToApp),
                  position: 8,
                  onTap: inheritedAuth.onLogout)
              : buildListTile(context, 'Sign in',
                  icon: const Icon(OMIcons.exitToApp),
                  position: 8,
                  onTap: inheritedAuth.onLogin),
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, String title,
      {Icon icon, String subtitle, int position, Function onTap}) {
    return subtitle != null
        ? ListTile(
            onTap: () {
              _selectedDrawerIndex = position;
              Navigator.pop(context);
            },
            selected: _selectedDrawerIndex == position,
            dense: true,
            leading: icon,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text(title), Text(subtitle)],
            ),
          )
        : ListTile(
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
