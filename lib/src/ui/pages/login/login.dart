import 'package:flutter/material.dart';
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/styled_button.dart' show StyledButton;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isAgree = false;
  bool _validPhone = false;
  String _countryCode = '+(357)';
  final TextEditingController _phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phone.addListener(_phoneListner);
  }

  void _phoneListner() {
    setState(() {
      _phone.text.isNotEmpty ? _validPhone = true : _validPhone = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        goBack: null,
        title: 'Log in',
        body: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Column(children: <Widget>[
              _buildTittle(),
              _buildPhonePicker(),
              _buildTerms(),
              _buildSubmit(),
            ])));
  }

  Widget _buildPhonePicker() {
    return Row(children: <Widget>[
      Container(
        width: 150.0,
        child: DropdownButton<String>(
          isDense: true,
          style: const TextStyle(fontSize: 16.0, color: Color(0xde000000)),
          isExpanded: true,
          value: _countryCode,
          onChanged: (String newValue) {
            setState(() {
              _countryCode = newValue;
            });
          },
          items: <String>[
            '+(357)',
            'Russia +7',
            'China +8',
            'France +9',
            'Usa +0'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 16.0, color: Color(0xde000000))),
            );
          }).toList(),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 12.0, top: 5.5),
        width: 200.0,
        child: TextField(
          controller: _phone,
          style: const TextStyle(fontSize: 16.0, color: Color(0xde000000)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration.collapsed(
              hintText: '26009875',
              hintStyle:
                  const TextStyle(color: Color(0xde000000), fontSize: 16.0),
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: const Color(0x0fffffff)))),
        ),
      )
    ]);
  }

  dynamic onChanged() {
    print('test');
  }

  Widget _buildTittle() {
    return Container(
        margin: const EdgeInsets.only(top: 56.0, bottom: 16.0),
        child: const Text(
          'Enter your phone number',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.start,
        ));
  }

  Widget _buildTerms() {
    return Row(
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
            const Text('I accept the',
                style: TextStyle(color: Color(0xde000000))),
            const Padding(padding: EdgeInsets.only(left: 2.0)),
            Text(
              'Term and conditions,Privacy police',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )
          ],
        )
      ],
    );
  }

  Widget _buildSubmit() {
    return Container(
        child: Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: StyledButton(
          loading: false,
          onPressed: _isAgree && _validPhone
              ? () {
                  print('some action');
                }
              : null,
          text: 'Submit',
        ),
      ),
    ));
  }
}
