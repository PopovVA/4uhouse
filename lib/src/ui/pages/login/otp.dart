import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_mobile/src/resources/phone_repository_test.dart';
import 'package:user_mobile/src/ui/components/pickers/phone/phone_picker.dart';
import '../../../blocs/phone/phone_bloc.dart';
import '../../../blocs/phone/phone_event.dart';
import '../../../blocs/phone/phone_state.dart';
import '../../../models/country_phone_data.dart';
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/snackbar.dart';
import '../../components/common/styled_button.dart' show StyledButton;

class OtpScreen extends StatefulWidget {
  const OtpScreen({@required this.selectedItem, @required this.phone});

  final CountryPhoneData selectedItem;
  final String phone;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: 'Confirm',
        body: Container(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Column(children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Text('Verification code was sent',
                        style: TextStyle(fontSize: 16.0)),
                    const Text('to the number',
                        style: TextStyle(fontSize: 16.0)),
                    Text(
                        '+ (' +
                            widget.selectedItem.code.toString() +
                            ') ' +
                            widget.phone,
                        style: const TextStyle(fontSize: 16.0))
                  ],
                )),
            Container(
                child: Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: StyledButton(
                  loading: false,
                  onPressed: () {
                    print('test');
                  },
                  text: 'Send',
                ),
              ),
            ))
          ]),
        ));
  }
}
