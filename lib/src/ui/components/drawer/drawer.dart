import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart'
    show OMIcons;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocBuilder, BlocListener, BlocListenerTree;
import 'package:user_mobile/src/models/auth/phone_model.dart';
import 'package:user_mobile/src/models/auth/user_info.dart';

import '../../../blocs/auth/auth_bloc.dart' show AuthBloc;
import '../../../blocs/auth/auth_event.dart' show AuthEvent;
import '../../../blocs/auth/auth_state.dart'
    show AuthState, AuthUnauthorized, AuthAuthorized;
import '../../../blocs/logout/logout_bloc.dart' show LogOutBloc;
import '../../../blocs/logout/logout_event.dart'
    show LogOutEvent, LogoutButtonTapped;
import '../../../blocs/logout/logout_state.dart'
    show LogOutError, LogOutNotActive, LogOutSending, LogOutState;
import '../../../resources/auth_repository.dart' show AuthRepository;
import '../../../utils/show_alert.dart' show showError;

import '../styled/styled_alert_dialog.dart' show StyledAlertDialog;
import '../styled/styled_circular_progress.dart' show StyledCircularProgress;
import 'drawer_header.dart' show Header;

class DrawerOnly extends StatefulWidget {
  const DrawerOnly({@required this.authBloc});

  final AuthBloc authBloc;

  @override
  State createState() => _DrawerState();
}

class _DrawerState extends State<DrawerOnly> {
  LogOutBloc logOutBloc;

  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    logOutBloc =
        LogOutBloc(authBloc: widget.authBloc, authRepository: AuthRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      //(state is AuthAuthorized)
                          //?
                      Header(userProfile: UserInfo(
                        preferredUsername: "Name",
                        phone: PhoneModel(
                          countryId: 'sdadasd',
                          number: '212321321312'
                        )
                      ))
                          //: Container()
                ,
                      buildListTile(context, 'Market',
                          icon: OMIcons.search, position: 0),
                      buildListTile(context, 'Likes',
                          icon: OMIcons.favoriteBorder, position: 1),
                      buildDivider(),
                      buildListTile(
                        context,
                        'Message',
                        icon: OMIcons.forum,
                        position: 2,
                      ),
                      buildListTile(context, 'Meeting',
                          icon: OMIcons.supervisorAccount, position: 3),
                      buildDivider(),
                      buildListTile(context, 'My account',
                          icon: OMIcons.accountCircle, position: 3),
                      buildListTile(context, 'Settings',
                          icon: OMIcons.settings, position: 6),
                      buildDivider(),
                      state is AuthUnauthorized
                          ? buildSignIn(context: context)
                          : buildSignOut(context: context)
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 48.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(63, 180, 188, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: OutlineButton(
                            //elevation: 8,
                            color: Colors.white,
                            onPressed: () {},
                            child: const Text(
                              'ADD PROPERTY',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(63, 180, 188, 1),
                              ),
                            )),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  Widget buildSignOut({@required BuildContext context}) {
    return BlocListenerTree(
        blocListeners: <BlocListener<dynamic, dynamic>>[
          BlocListener<LogOutEvent, LogOutState>(
            bloc: logOutBloc,
            listener: (BuildContext context, LogOutState state) {
              if (state is LogOutError) {
                showError(context, state);
              }
            },
          )
        ],
        child: BlocBuilder<LogOutEvent, LogOutState>(
          bloc: logOutBloc,
          builder: (BuildContext context, LogOutState state) {
            if (state is LogOutNotActive || state is LogOutError) {
              return buildListTile(context, 'Sign out',
                  icon: OMIcons.exitToApp, position: 8, onTap: () async {
                final bool logoutApproved = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StyledAlertDialog(
                        title: 'Sign out',
                        content: 'Are you sure you want to sign out?',
                        onOk: () {
                          Navigator.of(context).pop(true);
                        },
                        onCancel: () {
                          Navigator.of(context).pop(false);
                        },
                      );
                    });
                if (logoutApproved) {
                  logOutBloc.dispatch(LogoutButtonTapped());
                }
              });
            }

            if (state is LogOutSending) {
              return buildListTile(context, 'Sign out',
                  loading: true, position: 8);
            }

            return Container(width: 0.0, height: 0.0);
          },
        ));
  }

  Widget buildSignIn({@required BuildContext context}) {
    return buildListTile(context, 'Sign in',
        icon: OMIcons.exitToApp, position: 8, onTap: () {
      Navigator.of(context).pushNamed('login');
    });
  }

  Widget buildListTile(BuildContext context, String title,
      {IconData icon, int position, Function onTap, bool loading = false}) {
    return ListTile(
      onTap: loading
          ? null
          : () {
              _selectedDrawerIndex = position;
              onTap();
              Navigator.canPop(context);
            },
      selected: _selectedDrawerIndex == position,
      dense: true,
      leading: Container(
          width: 20,
          height: 20,
          child: loading
              ? StyledCircularProgress(
                  size: 'small', color: Theme.of(context).primaryColor)
              : Icon(
                  icon,
                  color: const Color.fromRGBO(117, 116, 116, 1),
                )),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0, right: 15.0),
      child: Divider(
        color: Color.fromRGBO(66, 65, 65, 0.38),
      ),
    );
  }
}
