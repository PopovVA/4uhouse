import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:user_mobile/src/blocs/auth/auth_event.dart';
import 'package:user_mobile/src/blocs/auth/auth_state.dart';
import 'package:user_mobile/src/resources/auth_repository.dart';
import 'package:user_mobile/src/ui/components/common/drawer/drawer.dart'
    show DrawerOnly;
import '../../../constants/layout.dart' show standardPadding;
import 'snackbar.dart';

class PageTemplate extends StatelessWidget {
  PageTemplate({
    this.title,
    this.note,
    this.body,
    this.goBack,
    this.padding = false,
  });

  static const Color color = Color(0xFF585555);
  static const double height = 68.0;

  final String title;
  final String note;
  final Widget body;
  final Function goBack;
  final bool padding;

  AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = padding ? standardPadding : 0.0;
    authBloc = AuthBloc(authRepository: AuthRepository());
    Future.delayed(Duration(seconds: 2), () {
      authBloc.dispatch(AppStarted());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFe9e7e7),
        iconTheme: const IconThemeData(color: color),
        leading: Navigator.canPop(context)
            ? IconButton(
                color: color,
                tooltip: 'go back',
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  return goBack is Function ? goBack() : Navigator.pop(context);
                })
            : null,
        centerTitle: true,
        title:
            Text(title, style: const TextStyle(color: color, fontSize: 20.0)),
      ),
      drawer: DrawerOnly(),
      body: BlocListener(
        bloc: authBloc,
        listener: (BuildContext context, AuthState state) {
          print('===> Pagetemplate==>state $state');
          if (state is PhoneError) {
            Scaffold.of(context).showSnackBar(CustomSnackBar(
              content: Text('Check your Internet in $title ${state.toString()}'),backgroundColor: Colors.redAccent,
            ));
          }
        },
        child: BlocBuilder<AuthEvent, AuthState>(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            print('===> state: ${state}');
            return Container(
              /* padding: EdgeInsets.fromLTRB(
              horizontalPadding, 0.0, horizontalPadding, standardPadding),*/
              child: body,
            );
          },
        ),
      ),
    );
  }
}