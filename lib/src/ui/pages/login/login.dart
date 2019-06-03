import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_mobile/src/blocs/phone/phone_bloc.dart';
import 'package:user_mobile/src/blocs/phone/phone_event.dart';
import 'package:user_mobile/src/blocs/phone/phone_state.dart';
import 'package:user_mobile/src/resources/phone_repository.dart';
import 'package:user_mobile/src/ui/components/common/snackbar.dart';
import '../../../utils/route_transition.dart' show SlideRoute;
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/styled_button.dart' show StyledButton;
import 'phone_search.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isAgree = false;
  bool _validPhone = false;
  String _defaultCountryCode = '+(357)';
  final TextEditingController _phone = TextEditingController();
  PhoneBloc _bloc;

  @override
  void initState() {
    super.initState();
    _phone.addListener(_phoneListner);
    _bloc = PhoneBloc(PhoneRepository());
    _bloc.dispatch(PhoneInitialized());
  }

  void _phoneListner() {
    setState(() {
      _phone.text.isNotEmpty ? _validPhone = true : _validPhone = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneEvent, PhoneState>(
      bloc: _bloc,
      listener: (BuildContext context, PhoneState state) {
        if (state is PhoneLoadingError) {
          Scaffold.of(context).showSnackBar(const CustomSnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.redAccent,
          ));
        }
      },
      child: BlocBuilder<PhoneEvent, PhoneState>(
          bloc: _bloc,
          builder: (BuildContext context, PhoneState state) {
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
          }),
    );

    ;
  }

  Widget _buildPhonePicker() {
    return Row(children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 12.0),
        width: 100.0,
        child: TextField(
          decoration: InputDecoration.collapsed(
              hintText: _defaultCountryCode,
              hintStyle:
                  const TextStyle(color: Color(0xde000000), fontSize: 16.0),
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: const Color(0x0fffffff)))),
          onTap: () => Navigator.push(
                context,
                SlideRoute(widget: PhoneSearch(), side: 'left'),
              ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 12.0),
        width: 240,
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
