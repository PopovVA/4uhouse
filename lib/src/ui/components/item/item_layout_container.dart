import 'package:flutter/material.dart';
import '../../../constants/layout.dart' show standardHorizontalPadding;

class ItemLayoutContainer extends StatelessWidget {
  const ItemLayoutContainer(this.child, {this.onTap});

  final Function onTap;
  final dynamic child;

  @override
  Widget build(BuildContext context) {
    final bool isOnTap = onTap is Function;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Ink(
        color: Colors.white,
        child: InkWell(
          onTap: isOnTap ? onTap : null,
          child: buildContainer(child),
        ),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 72.0,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: standardHorizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
