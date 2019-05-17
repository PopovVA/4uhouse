import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/user_profile.dart';
import '../../components/common/circular_progress.dart';
import '../../components/common/page_template.dart';
import '../../components/common/styled_button.dart';
import '../../components/inherited_auth.dart';
import 'components/description.dart';
import 'components/main_points.dart';
import 'components/sub_points.dart';

class HomePage extends StatelessWidget {
  final UserProfile user = UserProfile(
      name: 'Roman', email: 'rom12@gmail.com', phone: '89160001122');
  final bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return InheritedAuth(
        userProfile: user.toMap(),
        onLogin: () {},
        onLogout: () {},
        child: isLoading
            ? PageTemplate(
                title: 'My property',
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(top: 21),
                                      height: 130,
                                      child: SvgPicture.asset(
                                          'lib/assets/dog.svg')),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 17),
                                      child: Description()),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 22.0),
                            child: Column(
                              children: const <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: MainPoint(
                                        'Fill in some property information and send it to us',
                                        1)),
                                Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: MainPoint(
                                        'Choose a meeting time on the property and then we will do everything ourselves',
                                        2)),
                                Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: SubPoint(
                                        'Prepare and sign a contract with you')),
                                Padding(
                                    padding: EdgeInsets.only(right: 43),
                                    child: SubPoint(
                                        'Create a virtual property tour')),
                                Padding(
                                    padding: EdgeInsets.only(right: 28),
                                    child: SubPoint(
                                        'Prepare a property specification')),
                                Padding(
                                    padding: EdgeInsets.only(right: 13),
                                    child: SubPoint(
                                        'Prepare information for publication')),
                                Padding(
                                    padding: EdgeInsets.only(top: 13),
                                    child: MainPoint(
                                        'Agree on information for publication',
                                        3)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.only(top: 9, left: 15.0, right: 15.0),
                        child: StyledButton(
                          text: 'Add property',
                        )),
                  ],
                ))
            : const CircularProgress());
  }
}
