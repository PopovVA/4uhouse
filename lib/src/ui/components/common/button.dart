import 'package:flutter/material.dart';

import '../../../models/button_model.dart';
import 'package:provider_mobile/src/ui/components/common/styled_button.dart';

class Button extends StatefulWidget {
  final ButtonModel button;
  final String path;
  final Function handleSave;

  Button(this.button, this.path, this.handleSave);

  @override
  State<StatefulWidget> createState() {
    return _ButtonState();
  }
}

class _ButtonState extends State<Button> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ButtonModel button = widget.button;
    print('===> widget.button: ${widget.button}');
    return StyledButton(
      text: button.key.toUpperCase(),
      onPressed: button.isAble
          ? () async {
              setState(() => loading = true);
              await widget.handleSave(button.id, button.value);
              setState(() => loading = false);
            }
          : null,
      loading: loading,
    );
  }
}
