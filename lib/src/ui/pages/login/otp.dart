import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocListener, BlocListenerTree;

import '../../../../src/utils/route_transition.dart' show SlideRoute;
import '../../../blocs/auth/auth_bloc.dart' show AuthBloc;
import '../../../blocs/auth/auth_event.dart' show AuthEvent;
import '../../../blocs/auth/auth_state.dart' show AuthState, AuthAuthorized;
import '../../../blocs/login/login_bloc.dart' show LoginBloc;
import '../../../blocs/login/login_event.dart'
    show CodeEnteringCanceled, LoginEvent, SubmitCodeTapped;
import '../../../blocs/login/login_state.dart'
    show
    CodeError,
    IsFetchingCode,
    LoginState,
    OtpSent,
    PhoneEntering,
    PhoneError;
import '../../../models/country_phone_data.dart' show CountryPhoneData;

import '../../components/page_template.dart' show PageTemplate;
import '../../components/styled/styled_alert_dialog.dart'
    show StyledAlertDialog;
import '../../components/styled/styled_button.dart' show StyledButton;
import '../../components/styled/styled_text_field.dart' show StyledTextField;

class OtpScreen extends StatefulWidget {
  const OtpScreen({@required this.authBloc,
    @required this.loginBloc,
      @required this.selectedItem,
    @required this.number,
      this.previousRoute});

  final AuthBloc authBloc;
  final LoginBloc loginBloc;
  final CountryPhoneData selectedItem;
  final String number;
  final SlideRoute previousRoute;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isFetchingCode = false;
  final int maxLength = 4;
  TextEditingController code = TextEditingController();

  @override
  void initState() {
    super.initState();
    code.addListener(_codeListener);
  }

  void _codeListener() {
    setState(() {});
  }

  void _showError(BuildContext context, LoginState state) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StyledAlertDialog(
            content: state.toString(),
            onOk: () {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('===> auth bloc: ${widget.authBloc}');
    return PageTemplate(
        goBack: () {
          widget.loginBloc.dispatch(CodeEnteringCanceled());
        },
        title: 'Confirm',
        body: Container(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          margin: const EdgeInsets.only(bottom: 12.0),
          child: BlocListenerTree(
            blocListeners: <BlocListener<dynamic, dynamic>>[
              BlocListener<AuthEvent, AuthState>(
                bloc: widget.authBloc,
                listener: (BuildContext context, AuthState state) {
                  if (state is AuthAuthorized) {
                    // Убиваем оба рута (страница ввода номера телефона, страница ввода sms-кода).
                    Navigator.of(context)
                        .removeRouteBelow(ModalRoute.of(context));
                    Navigator.of(context).removeRoute(ModalRoute.of(context));
                  }
                },
              ),
              BlocListener<LoginEvent, LoginState>(
                bloc: widget.loginBloc,
                listener: (BuildContext context, LoginState state) {
                  print('===> state listener name  ${state.runtimeType}');
                  if (state is PhoneError || state is CodeError) {
                    _showError(context, state);
                  }

                  if (state is CodeError) {
                    code.clear();
                    _showError(context, state);
                  }

                  if (state is PhoneEntering) {
                    // Убиваем рут (возвращаемся на экран ввода номера телефона).
                    Navigator.pop(context);
                  }
                },
              )
            ],
            child: BlocBuilder<LoginEvent, LoginState>(
                bloc: widget.loginBloc,
                builder: (BuildContext context, LoginState state) {
                  print('===> state builder name : ' + state.toString());
                  if (state is OtpSent) {
                    return Column(children: <Widget>[
                      _buildHeadLine(),
                      _buildCodeInput(),
                      _buildSendButton()
                    ]);
                  }

                  if (state is IsFetchingCode) {
                    isFetchingCode = true;
                    return Column(children: <Widget>[
                      _buildHeadLine(),
                      _buildCodeInput(),
                      _buildSendButton()
                    ]);
                  }

                  return Container(width: 0.0, height: 0.0);
                }),
          ),
        ));
  }

  Widget _buildHeadLine() {
    return Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Text('Verification code was sent',
                style: TextStyle(fontSize: 16.0)),
            const Text('to the number', style: TextStyle(fontSize: 16.0)),
            Text(
                '+ (' +
                    widget.selectedItem.code.toString() +
                    ') ' +
                    widget.number,
                style: const TextStyle(fontSize: 16.0))
          ],
        ));
  }

  Widget _buildSendButton() {
    return Container(
        child: Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: StyledButton(
          loading: isFetchingCode ? true : false,
          onPressed: isFetchingCode == false && code.text.length != maxLength
              ? null
              : () {
            widget.loginBloc.dispatch(SubmitCodeTapped(
                code: widget.selectedItem.code,
                number: widget.number,
                otp: code.text));
                },
          text: 'Send',
        ),
      ),
    ));
  }

  Widget _buildCodeInput() {
    return Container(
      margin: const EdgeInsets.only(top: 26.0),
      child: StyledTextField(
        autofocus: true,
        borderColor: code.text.length != maxLength
            ? Colors.redAccent
            : Theme
            .of(context)
            .primaryColor,
        controller: code,
        textAlign: TextAlign.center,
        maxLength: maxLength,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      width: 312,
    );
  }
}