import 'package:flutter/material.dart';
import 'package:user_mobile/src/constants/layout.dart';
import '../../../constants/layout.dart';
import 'styled_circular_progress.dart';

class StyledButton extends StatelessWidget {
  const StyledButton(
      {this.text = '', this.onPressed, this.loading = false, this.color});

  final String text;
  final Function onPressed;
  final bool loading;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: standardVerticalPadding,
          left: standardHorizontalPadding,
          right: standardHorizontalPadding),
      child: SafeArea(
        child: Container(
            height: 48.0,
            width: double.infinity,
            child: RaisedButton(
              color: color != null
                  ? Color(int.parse(color))
                  : Theme.of(context).primaryColor,
              disabledColor: const Color(0xE6CACACA),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              onPressed: loading ? null : onPressed,
              child: buildChild(context),
            )),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    if (loading) {
      return const StyledCircularProgress(size: 'sm', color: Colors.white);
    }

    return Text(
      text,
      style: TextStyle(fontSize: 14.0,
          fontStyle: FontStyle.normal,
          color: const Color(0xFFFFFFFFF)),
    );
  }
}
