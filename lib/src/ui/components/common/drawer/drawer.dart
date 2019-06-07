import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder;

import '../../../../blocs/auth/auth_bloc.dart' show AuthBloc;
import '../../../../blocs/auth/auth_event.dart'
    show AuthEvent, LoginButtonPressed, LogoutButtonPressed;
import '../../../../blocs/auth/auth_state.dart' show AuthState, AuthAuthorized;

import 'drawer_header.dart' show Header;

class DrawerOnly extends StatefulWidget {
  @override
  State createState() => DrawerState();
}

class DrawerState extends State<DrawerOnly> {
  int _selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
//    final InheritedAuth inheritedAuth = InheritedAuth.of(context);
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthEvent, AuthState>(
        bloc: authBloc,
        builder: (BuildContext context, AuthState state) {
          return Drawer(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      (state is AuthAuthorized)
                          ? Header(userProfile: state.userProfile)
                          : Container(),
                      buildListTile(context, 'Market',
                          icon: const Icon(OMIcons.search), position: 0),
                      buildListTile(context, 'Likes',
                          icon: const Icon(OMIcons.favoriteBorder),
                          position: 1),
                      buildDivider(),
                      buildListTile(
                        context,
                        'Message',
                        icon: const Icon(OMIcons.forum),
                        position: 2,
                      ),
                      buildListTile(context, 'Meeting',
                          icon: const Icon(OMIcons.supervisorAccount),
                          position: 3),
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
                        state is AuthAuthorized
                            ? buildListTile(context, 'Sign out',
                                icon: const Icon(OMIcons.exitToApp),
                                position: 8, onTap: () {
                                authBloc.dispatch(LogoutButtonPressed());
                              })
                            : buildListTile(context, 'Sign in',
                                icon: const Icon(OMIcons.exitToApp),
                                position: 8, onTap: () {
                                authBloc.dispatch(LoginButtonPressed());
                              }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget buildListTile(BuildContext context, String title,
      {Icon icon, int position, Function onTap}) {
    return ListTile(
      onTap: () {
        _selectedDrawerIndex = position;
        onTap();
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
