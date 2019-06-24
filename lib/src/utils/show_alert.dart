import 'package:flutter/material.dart';

import '../ui/components/styled/styled_alert_dialog.dart'
    show StyledAlertDialog;

void showError(BuildContext context, dynamic state) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StyledAlertDialog(
          content: state.toString(),
          onOk: () {
            Navigator.of(context).pop();
          },
        );
      });
}
