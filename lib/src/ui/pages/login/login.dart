import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/phone/phone_bloc.dart';
import '../../../blocs/phone/phone_event.dart';
import '../../../blocs/phone/phone_state.dart';
import '../../../resources/phone_repository.dart';
import '../../../utils/route_transition.dart' show SlideRoute;
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/snackbar.dart';
import '../../components/common/styled_button.dart' show StyledButton;
import 'phone_search.dart';
import 'phone_picker.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isAgree = false;
  bool _validPhone = false;
  PhoneBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PhoneBloc(PhoneRepository());
    _bloc.dispatch(PhoneInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        goBack: null,
        title: 'Log in',
        body: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            margin: const EdgeInsets.only(bottom: 12.0),
            child: BlocListener<PhoneEvent, PhoneState>(
                bloc: _bloc,
                listener: (BuildContext context, PhoneState state) {
                  print('=> $state');
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
                      if (state is PhoneLoading) {
                        return Column(children: <Widget>[
                          _buildTittle(),
                          CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor),
                          _buildTerms(),
                          _buildSubmit(),
                        ]);
                      }
                      if (state is PhoneCountriesDataLoaded) {
                        return Column(children: <Widget>[
                          _buildTittle(),
                          PhonePicker(),
                          _buildTerms(),
                          _buildSubmit(),
                        ]);
                      }
                      if (state is PhoneLoadingError) {
                        return Column(children: <Widget>[
                          _buildTittle(),
                          PhonePicker(),
                          _buildTerms(),
                          _buildSubmit(),
                        ]);
                      }
                    }))));
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
