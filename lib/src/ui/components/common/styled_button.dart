import 'package:flutter/material.dart';
import 'package:provider_mobile/src/ui/components/common/circular_progress.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({this.text = '', this.onPressed, this.loading = false});

  final String text;
  final Function onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        disabledColor: const Color(0xE6CACACA),
        elevation: 8,
        onPressed: loading ? null : onPressed,
        child: buildChild(context),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    print('---> loading: $loading');
    if (loading) {
      return const CircularProgress(size: 'small', color: Colors.white);
    }

    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.button,
    );
  }
}
