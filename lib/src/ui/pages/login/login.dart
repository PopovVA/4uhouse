import 'package:flutter/material.dart';
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/styled_button.dart' show StyledButton;
import 'components/phone_picker.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isAgree = false;

  //здесь буду ожидать от блока состояния, пока сделал переменную для теста
  bool _sendingRespone = false;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: 'Log in',
        body: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Column(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 56.0, bottom: 16.0),
                  child: Text(
                    'Enter your phone number',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.start,
                  )),
              Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: PhonePicker(
                    //Тут не очень понял как сделать, обсудим на планерке
                    onGoBack: () => {},
                    onSubmit: (String phoneNumber) => {print(phoneNumber)},
                  )),
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: _isAgree,
                    onChanged: (bool value) {
                      setState(() {
                        _isAgree = !_isAgree;
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      const Text('I accept the'),
                      const Padding(padding: EdgeInsets.only(left: 2.0)),
                      Text(
                        'Term and conditions,Privacy police',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  )
                ],
              ),
              Container(
                  child: Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: StyledButton(
                    loading: _sendingRespone,
                    onPressed: _isAgree ? () => print('Some action') : null,
                    text: 'Submit',
                  ),
                ),
              ))
            ])));
  }
}
