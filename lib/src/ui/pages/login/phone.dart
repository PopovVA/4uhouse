import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_mobile/temp/phone_repository_test.dart';
import 'package:user_mobile/src/ui/components/pickers/phone/phone_picker.dart';
import '../../../../src/utils/route_transition.dart' show SlideRoute;
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_event.dart';
import '../../../blocs/phone/phone_bloc.dart';
import '../../../blocs/phone/phone_event.dart';
import '../../../blocs/phone/phone_state.dart';
import '../../../models/country_phone_data.dart';
import '../../../resources/auth_repository.dart';
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/snackbar.dart';
import '../../components/common/styled_button.dart' show StyledButton;
import 'otp.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({@required this.authBloc});

  final AuthBloc authBloc;

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  bool isAgree = false;
  bool validPhone = false;
  PhoneBloc _bloc;
  LoginBloc _loginBloc;
  CountryPhoneData selectedItem;
  String phone;

  @override
  void initState() {
    super.initState();
    _bloc = PhoneBloc(TestPhoneRepository());
    _bloc.dispatch(PhoneInitialized());
    _loginBloc = LoginBloc(widget.authBloc, AuthRepository());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        goBack: null,
        title: 'Log in',
        body: Container(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            margin: const EdgeInsets.only(bottom: 12.0),
            child: BlocListener<PhoneEvent, PhoneState>(
                bloc: _bloc,
                listener: (BuildContext context, PhoneState state) {
                  print('===> state listener name : ' + state.toString());
                  if (state is PhoneLoadingError) {
                    Scaffold.of(context).showSnackBar(CustomSnackBar(
                      content: Text(state.toString()),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                },
                child: BlocBuilder<PhoneEvent, PhoneState>(
                    bloc: _bloc,
                    builder: (BuildContext context, PhoneState state) {
                      print('===> state builder name : ' + state.toString());
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
                          PhonePicker(
                              onSelected: (bool value,
                                  CountryPhoneData countryPhone,
                                  String inputtedPhone) {
                                setState(() {
                                  validPhone = value;
                                  selectedItem = countryPhone;
                                  phone = inputtedPhone;
                                });
                              },
                              countryPhoneDataList: state.data,
                              favorites: const <String>['RU', 'AL']),
                          _buildTerms(),
                          _buildSubmit(),
                        ]);
                      }
                      if (state is PhoneLoadingError) {
                        return Column(children: <Widget>[
                          _buildTittle(),
                          const Text('Something went wrong'),
                          _buildTerms(),
                          _buildSubmit(),
                        ]);
                      }
                      //В постаноке не увидел описание этого состояния, сделал по аналогии с PhoneLoadingError
                      if (state is PhoneUninitialized) {
                        return Column(children: <Widget>[
                          _buildTittle(),
                          const Text('Something went wrong'),
                          _buildTerms(),
                          _buildSubmit(),
                        ]);
                      }
                    }))));
  }

  Widget _buildTittle() {
    return Container(
        alignment: const Alignment(-1, 0),
        margin: const EdgeInsets.only(top: 56.0, bottom: 16.0, left: 14.0),
        child: const Text('Enter your phone number',
            style: TextStyle(fontSize: 16)));
  }

  Widget _buildTerms() {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(children: <Widget>[
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: isAgree,
            onChanged: (bool value) {
              setState(() {
                isAgree = !isAgree;
              });
            },
          ),
          Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('I accept the',
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xde000000))),
                        Text(' Term and conditions,',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).primaryColor))
                      ],
                    ),
                    Text('Privacy policy',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor)),
                  ])),
        ]));
  }

  Widget _buildSubmit() {
    return Container(
        child: Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: StyledButton(
          loading: false,
          onPressed: isAgree && validPhone
              ? () {
                _loginBloc.dispatch(OtpRequested(phone));
                  Navigator.push(
                      context,
                      SlideRoute(
                          widget: OtpScreen(loginBloc:_loginBloc,previousRoute: ModalRoute.of(context),
                              selectedItem: selectedItem, phone: phone),
                          side: "left"));
                }
              : null,
          text: 'Submit',
        ),
      ),
    ));
  }
}
