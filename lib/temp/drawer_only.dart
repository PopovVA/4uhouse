import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class DrawerOnly extends StatelessWidget {
  Function changeDrawerPosition;
  int _selectedDrawerIndex = 0;
  String name = "Roman";
  String mail = "rom12@gmail.com";
  String number = "89160001122";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          buildDrawerHeader(context),
          Divider(
            color: Color.fromRGBO(66, 65, 65, 0.38),
          ),
          buildListTile("Market", Icon(OMIcons.search), null, 0, context),
          buildListTile(
              "Likes", Icon(OMIcons.favoriteBorder), null, 1, context),
          buildDivider(),
          buildListTile("Message", Icon(OMIcons.forum), "10/1", 2, context),
          buildListTile("Meeting at the property",
              Icon(OMIcons.supervisorAccount), "0", 3, context),
          buildDivider(),
          buildListTile("My property", Icon(OMIcons.image), null, 4, context),
          buildListTile("My tasks", Icon(OMIcons.checkBox), null, 5, context),
          buildDivider(),
          buildListTile("Settings", Icon(OMIcons.settings), null, 6, context),
          buildListTile("Forum", Icon(OMIcons.speakerNotes), null, 7, context),
          buildListTile("Sign out", Icon(OMIcons.exitToApp), null, 8, context),
        ],
      ),
    );
  }

  Widget buildListTile(String title, Icon icon, String subtitle, int position,
      BuildContext context) {
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

  Widget buildDrawerHeader(BuildContext context) {
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
                    onPressed: () {})
              ],
            ),
          ]),
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
