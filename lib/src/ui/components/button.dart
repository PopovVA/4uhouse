import 'package:flutter/material.dart';

import '../../models/screen/components/button_model.dart';
import '../components/styled/styled_button.dart' show StyledButton;

class Button extends StatefulWidget {
  const Button(this.button, this.path, this.handleSave);

  final ButtonModel button;
  final String path;
  final Function handleSave;

  @override
  State<StatefulWidget> createState() {
    return _ButtonState();
  }
}

class _ButtonState extends State<Button> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final ButtonModel button = widget.button;
    return StyledButton(
      text: button.key.toUpperCase(),
      onPressed: button.isAble
          ? () async {
              setState(() => loading = true);
              await widget.handleSave(
                  button.id, button.typeQuery == 'PUT' ? button.value : null);
              setState(() => loading = false);
            }
          : null,
      loading: loading,
    );
  }
}
