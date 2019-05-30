import 'package:tel_input/tel_input.dart';
import 'package:flutter/material.dart';

class PhonePicker extends StatelessWidget {
  const PhonePicker({@required this.onSubmit});

  ///RUS
  ///Колбэк который возвращает введенный номер телефона
  ///
  /// ENG
  /// Callback which return inputted phone number
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => TelInput(
          dialCode: '+852',
          includeDialCode: true,
          onChange: (String phoneNumber) {
            return onSubmit is Function ? onSubmit(phoneNumber) : null;
          }),
    );
  }
}
