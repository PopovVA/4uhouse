import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class DrawerOnly extends StatelessWidget {
  Function changeDrawerPosition;
  int _selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(),
          Divider(
            color: Color.fromRGBO(66, 65, 65, 0.38),
          ),
          buildListTile(context, "Market",
              icon: Icon(OMIcons.search), position: 0),
          buildListTile(context, "Likes",
              icon: Icon(OMIcons.favoriteBorder), position: 1),
          buildDivider(),
          buildListTile(
            context,
            "Message",
            icon: Icon(OMIcons.forum),
            subtitle: "10/1",
            position: 2,
          ),
          buildListTile(context, "Meeting at the property",
              icon: Icon(OMIcons.supervisorAccount),
              subtitle: "0",
              position: 3),
          buildDivider(),
          buildListTile(context, "My property",
              icon: Icon(OMIcons.image), position: 4),
          buildListTile(context, "My tasks",
              icon: Icon(OMIcons.checkBox), position: 5),
          buildDivider(),
          buildListTile(context, "Settings",
              icon: Icon(OMIcons.settings), position: 6),
          buildListTile(
            context,
            "Forum",
            icon: Icon(OMIcons.speakerNotes),
            position: 7,
          ),
          buildListTile(context, "Sign out",
              icon: Icon(OMIcons.exitToApp), position: 8),
        ],
      ),
    );
  }

  Widget buildListTile(
    BuildContext context,
    String title, {
    Icon icon,
    String subtitle,
    int position,
  }) {
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
        color: Color.fromRGBO(66, 65, 65, 0.38),
      ),
    );
  }
}
