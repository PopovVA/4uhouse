import 'package:flutter/material.dart';
import '../../../constants/layout.dart' show standardHorizontalPadding;

class ItemLayoutContainer extends StatelessWidget {
  const ItemLayoutContainer(this.child, {this.onTap, this.disabled});

  final Function onTap;
  final dynamic child;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Ink(
        color: Colors.white,
        child: InkWell(
          onTap: onTap is Function ? onTap : null,
          child: buildContainer(child),
        ),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: !disabled ? 72.0 : 0.0,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: standardHorizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
