import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import '../../../blocs/auth/auth_state.dart';

class Header extends StatelessWidget {
  const Header({this.state});

  final AuthState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildUserInfo(state),
        IconButton(
            icon: const Icon(
              OMIcons.close,
              color: Color.fromRGBO(0, 0, 0, 0.54),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }

  Widget buildUserInfo(AuthState state) {
    return (state is AuthAuthorized)
        ? Expanded(
            child: ListTile(
              title: Text(
                state.userProfile.phone.number,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Color.fromRGBO(0, 0, 0, 0.87)),
              ),
              leading: Icon(
                OMIcons.phone,
                color: const Color.fromRGBO(117, 116, 116, 1),
              ),
            ),
          )
        : Container();
  }
}
