import 'package:tel_input/tel_input.dart';
import 'package:flutter/material.dart';

class PhonePicker extends StatelessWidget {
  const PhonePicker({@required this.onSubmit, @required this.onGoBack});
  ///RUS
  ///Описание
  ///
  /// ENG
  /// Description
  final Function onSubmit;
  ///RUS
  ///Описание
  ///
  /// ENG
  /// Description
  final Function onGoBack;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => TelInput(
            dialCode: '+852',
            includeDialCode: true,
            onChange: (String phoneNumber) =>
                print('phoneNumber: $phoneNumber'),
          ),
    );
  }
}
