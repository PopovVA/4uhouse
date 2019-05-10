import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class DrawerOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Roman', style: TextStyle(fontSize: 20))
                    ],
                  ),
                  Text('sup@help.cc'),
                  Row(
                    children: <Widget>[Text('89160001122')],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('My advert'),
            leading: Icon(OMIcons.image),
          ),
          ListTile(
            title: Text('On check'),
            leading: Icon(OMIcons.errorOutline),
          ),
          ListTile(
            title: Text('Draft ad'),
            leading: Icon(OMIcons.receipt),
          ),
          ListTile(
            title: Text('Messages'),
            leading: Icon(OMIcons.mailOutline),
          ),
          ListTile(
            title: Text('Payments'),
            leading: Icon(OMIcons.accountBalanceWallet),
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(OMIcons.settings),
          ),
          ListTile(
            title: Text('Forum'),
            leading: Icon(OMIcons.message),
          ),
          ListTile(
            title: Text('Sign out'),
            leading: Icon(OMIcons.exitToApp),
          )
        ],
      ),
    );
  }
}
