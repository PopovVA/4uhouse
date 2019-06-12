import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src/utils/route_transition.dart' show SlideRoute;
import '../../../blocs/auth/auth_state.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_event.dart';
import '../../../blocs/login/login_state.dart';
import '../../../models/country_phone_data.dart';
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/snackbar.dart';
import '../../components/common/styled_button.dart' show StyledButton;
import '../../components/resend.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {@required this.loginBloc,
      @required this.selectedItem,
      @required this.phone,
      this.previousRoute});

  final CountryPhoneData selectedItem;
  final String phone;
  final LoginBloc loginBloc;
  final SlideRoute previousRoute;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isFetchingCode = false;
  final int maxLength = 6;
  TextEditingController code = TextEditingController();

  @override
  void initState() {
    super.initState();
    code.addListener(_codeListener);
  }

  void _codeListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        goBack: () {
          widget.loginBloc.dispatch(CodeEnteringCanceled(widget.phone));
          Navigator.pop(context);
        },
        title: 'Confirm',
        body: Container(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          margin: const EdgeInsets.only(bottom: 12.0),
          child: BlocListener<LoginEvent, LoginState>(
            bloc: widget.loginBloc,
            listener: (BuildContext context, LoginState state) {
              print('===> state listener name : ' + state.toString());
              if (state is PhoneError || state is CodeError) {
                Scaffold.of(context).showSnackBar(CustomSnackBar(
                  content: Text(state.toString()),
                  backgroundColor: Colors.redAccent,
                ));
              }
              if (state is CodeError) {
                //Очищаешь TextField.
                print('CodeError');
                code.clear();
                Scaffold.of(context).showSnackBar(CustomSnackBar(
                  content: Text(state.toString()),
                  backgroundColor: Colors.redAccent,
                ));
              }
              if (state is PhoneEntering) {
                //Убиваем рут (возвращаемся на экран ввода номера телефона).
                print('PhoneEntering');
                Navigator.pop(context);
              }
              if (state is AuthAuthorized) {
                //Убиваем оба рута (страница ввода номера телефона, страница ввода sms-кода).
                print('AuthAuthorized');
                widget.previousRoute.didPop(null);
                ModalRoute.of(context).didPop(null);
              }
            },
            child: BlocBuilder<LoginEvent, LoginState>(
                bloc: widget.loginBloc,
                builder: (BuildContext context, LoginState state) {
                  print('===> state builder name : ' + state.toString());
                  if (state is OtpSent) {
                    return Column(children: <Widget>[
                      _buildHeadLine(),
                      _buildCodeInput(),
                      Resend(
                          type: 'Timer',
                          onPressed: () {
                            widget.loginBloc
                                .dispatch(OtpRequested(widget.phone));
                          }),
                      _buildSendButton()
                    ]);
                  }
                  if (state is IsFetchingOtp) {
                    //Вместо виджета Resend отображаем индикатор загрузки.
                    return Column(children: <Widget>[
                      _buildHeadLine(),
                      _buildCodeInput(),
                      const Resend(type: 'Circular'),
                      _buildSendButton()
                    ]);
                  }
                  if (state is IsFetchingCode) {
                    //Кнопка "Send" задизаблена и показывает индикатор загрузки. Реализовать через styled_button.
                    isFetchingCode = true;
                    return Column(children: <Widget>[
                      _buildHeadLine(),
                      _buildCodeInput(),
                      Resend(
                          type: 'Timer',
                          onPressed: () {
                            widget.loginBloc
                                .dispatch(OtpRequested(widget.phone));
                          }),
                      _buildSendButton()
                    ]);
                  }
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
                    widget.phone,
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
                  widget.loginBloc.dispatch(
                      SubmitCodeTapped(widget.phone, int.parse(code.text)));
                },
          text: 'Send',
        ),
      ),
    ));
  }

  Widget _buildCodeInput() {
    return Container(
      margin: const EdgeInsets.only(top: 26.0),
      width: 312,
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        controller: code,
        maxLength: maxLength,
        style: const TextStyle(fontSize: 16.0, color: Color(0xde000000)),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0.0),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.0,
                    color: code.text.length != maxLength
                        ? Colors.redAccent
                        : Theme.of(context).primaryColor))),
      ),
    );
  }
}
