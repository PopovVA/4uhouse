import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_mobile/src/resources/auth_repository.dart';
import 'package:user_mobile/src/ui/components/pickers/phone/phone_picker.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_state.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_event.dart';
import '../../../blocs/login/login_state.dart';
import '../../../models/country_phone_data.dart';
import '../../../resources/auth_repository.dart';
import '../../components/common/page_template.dart' show PageTemplate;
import '../../components/common/snackbar.dart';
import '../../components/common/styled_button.dart' show StyledButton;
import '../home/home.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({@required this.selectedItem, @required this.phone});

  final CountryPhoneData selectedItem;
  final String phone;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  LoginBloc _bloc;
  bool isFetchingCode = false;
  final int maxLength = 6;
  TextEditingController code = TextEditingController();
  Timer timer;
  int start;

  void startTimer() {
    start = 60;
    const Duration oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (start < 1) {
                timer.cancel();
              } else {
                start = start - 1;
              }
            },
          ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc =
        LoginBloc(AuthBloc(authRepository: AuthRepository()), AuthRepository());
    _bloc.dispatch(OtpRequested(widget.phone));
    code.addListener(_codeListener);
    startTimer();
  }

  void _codeListener() {
    print(code.text);
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        goBack: () => _bloc.dispatch(CodeEnteringCanceled(widget.phone)),
        title: 'Confirm',
        body: Container(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Column(children: <Widget>[
            _buildHeadLine(),
            BlocListener<LoginEvent, LoginState>(
              bloc: _bloc,
              listener: (BuildContext context, LoginState state) {
                print('===> state listener name : ' + state.toString());
                if (state is PhoneError || state is CodeError) {
                  Scaffold.of(context).showSnackBar(const CustomSnackBar(
                    content: Text('Something went wrong'),
                    backgroundColor: Colors.redAccent,
                  ));
                }
                if (state is CodeError) {
                  //Очищаешь TextField.
                  print('CodeError');
                  code.clear();
                }
                if (state is PhoneEntering) {
                  //Убиваем рут (возвращаемся на экран ввода номера телефона).
                  print('PhoneEntering');
                  //Так как это стартовый стейт в LoginBloc роут закрывается при открытии, поэтому закоментил, возможно в постановке ошибка?
                  //Navigator.pop(context);
                }
                if (state is AuthAuthorized) {
                  //Убиваем оба рута (страница ввода номера телефона, страница ввода sms-кода).
                  print('AuthAuthorized');
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                }
              },
              child: BlocBuilder<LoginEvent, LoginState>(
                  bloc: _bloc,
                  builder: (BuildContext context, LoginState state) {
                    print('===> state builder name : ' + state.toString());
                    if (state is PhoneEntering) {
                      // В постановке этот стейт есть только в BlocListener
                      return Container();
                    }
                    if (state is OtpSent) {
                      return _buildCodeInput();
                    }
                    if (state is IsFetchingOtp) {
                      //Вместо виджета Resend отображаем индикатор загрузки.
                      return CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor);
                    }
                    if (state is IsFetchingCode) {
                      //Кнопка "Send" задизаблена и показывает индикатор загрузки. Реализовать через styled_button.
                      isFetchingCode = true;
                      return _buildCodeInput();
                    }
                  }),
            ),
            _buildResentCode(),
            _buildSendButton(),
          ]),
        ));
  }

  Widget _buildResentCode() {
    return Container(
        margin: const EdgeInsets.only(top: 18.0),
        child: start != 0
            ? Text('Resend code through 00.$start sec',
                style: const TextStyle(fontSize: 14, color: Color(0x8a000000)))
            : InkWell(
                onTap: () {
                  _bloc.dispatch(OtpRequested(widget.phone));
                  setState(() {
                    startTimer();
                  });
                },
                child: Text('Resent code',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).primaryColor))));
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
                  _bloc.dispatch(
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
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 2.0, color: const Color.fromRGBO(175, 173, 173, 0.4))),
        ),
      ),
    );
  }
}
