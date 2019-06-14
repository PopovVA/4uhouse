import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocListener, BlocListenerTree;

import '../../../../src/utils/route_transition.dart' show SlideRoute;
import '../../../blocs/auth/auth_bloc.dart' show AuthBloc;
import '../../../blocs/login/login_bloc.dart' show LoginBloc;
import '../../../blocs/login/login_event.dart' show LoginEvent, OtpRequested;
import '../../../blocs/login/login_state.dart'
    show LoginState, IsFetchingOtp, OtpSent, PhoneError;
import '../../../blocs/phone/phone_bloc.dart' show PhoneBloc;
import '../../../blocs/phone/phone_event.dart'
    show PhoneEvent, PhoneInitialized;
import '../../../blocs/phone/phone_state.dart'
    show
        PhoneCountriesDataLoaded,
        PhoneLoading,
        PhoneLoadingError,
        PhoneState,
        PhoneUninitialized;
import '../../../models/country_phone_data.dart' show CountryPhoneData;
import '../../../resources/auth_repository.dart' show AuthRepository;
import '../../../resources/phone_repository.dart' show PhoneRepository;

import '../../components/common/alert_dialog.dart' show CustomAlertDialog;
import '../../components/common/circular_progress.dart' show CircularProgress;
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/styled_button.dart' show StyledButton;
import '../../components/pickers/phone/phone_picker.dart' show PhonePicker;
import 'otp.dart' show OtpScreen;

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({@required this.authBloc});

  final AuthBloc authBloc;

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  bool isAgree = true;
  bool validPhone = false;
  PhoneBloc _phoneBloc;
  LoginBloc _loginBloc;
  CountryPhoneData selectedItem;
  String number;

  @override
  void initState() {
    super.initState();
    _phoneBloc = PhoneBloc(PhoneRepository());
    _phoneBloc.dispatch(PhoneInitialized());
    _loginBloc = LoginBloc(widget.authBloc, AuthRepository());
  }

  @override
  void dispose() {
    super.dispose();
    _phoneBloc.dispose();
  }

  void _showError(BuildContext context, dynamic state) {
    showDialog(context: context, builder: (BuildContext context) {
      return CustomAlertDialog(
        content: state.toString(),
        onOk: () {
          Navigator.of(context).pop();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        goBack: null,
        title: 'Log in',
        body: Container(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            margin: const EdgeInsets.only(bottom: 12.0),
            child: BlocListenerTree(
                blocListeners: <BlocListener<dynamic, dynamic>>[
                  BlocListener<LoginEvent, LoginState>(
                      bloc: _loginBloc,
                      listener: (BuildContext context, LoginState state) {
                        if (state is OtpSent) {
                          Navigator.push(
                              context,
                              SlideRoute(
                                  widget: OtpScreen(
                                      authBloc: widget.authBloc,
                                      loginBloc: _loginBloc,
                                      previousRoute: ModalRoute.of(context),
                                      selectedItem: selectedItem,
                                      number: number),
                                  side: 'left'));
                        }
                        if (state is PhoneError) {
                          _showError(context, state);
                        }
                      }),
                  BlocListener<PhoneEvent, PhoneState>(
                    bloc: _phoneBloc,
                    listener: (BuildContext context, PhoneState state) {
                      if (state is PhoneLoadingError) {
                        _showError(context, state);
                      }
                    },
                  )
                ],
                child: BlocBuilder<PhoneEvent, PhoneState>(
                    bloc: _phoneBloc,
                    builder: (BuildContext context, PhoneState state) {
                      print('===> state builder name : ${state.runtimeType}');
                      return Column(
                        children: <Widget>[
                          _buildTittle(),
                          if (state is PhoneUninitialized ||
                              state is PhoneLoading)
                            CircularProgress(
                                size: 'small',
                                color: Theme.of(context).primaryColor),
                          if (state is PhoneCountriesDataLoaded)
                            _buildPhonePicker(state),
                          if (state is PhoneLoadingError)
                            Text(state.toString()),
                          _buildTerms(),
                          _buildSubmit(loginBloc: _loginBloc),
                        ],
                      );
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

  Widget _buildPhonePicker(PhoneCountriesDataLoaded state) {
    return PhonePicker(
        onSelected:
            (bool value, CountryPhoneData countryPhone, String inputtedPhone) {
          setState(() {
            validPhone = value;
            selectedItem = countryPhone;
            number = inputtedPhone;
          });
        },
        countryPhoneDataList: state.data,
        favorites: const <String>['RU', 'CY']);
  }

  Widget _buildSubmit({@required LoginBloc loginBloc}) {
    return BlocBuilder<LoginEvent, LoginState>(
        bloc: loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Container(
              child: Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: StyledButton(
                loading: state is IsFetchingOtp,
                onPressed: isAgree && validPhone
                    ? () {
                        _loginBloc.dispatch(OtpRequested(
                            countryId: selectedItem.countryId,
                            code: selectedItem.code,
                            number: number));
                      }
                    : null,
                text: 'Submit',
              ),
            ),
          ));
        });
  }
}
