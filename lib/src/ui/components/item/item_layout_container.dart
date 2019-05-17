import 'package:flutter/material.dart';
import '../../../constants/layout.dart' show standardPadding;

class ItemLayoutContainer extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ItemLayoutContainer(this.child, {this.onTap});

  final Function onTap;
  final dynamic child;


  @override
  Widget build(BuildContext context) {
    if (onTap is Function) {
      return InkWell(
        onTap: onTap,
        child: buildContainer(child),
      );
    }

    return buildContainer(child);
  }

  // ignore: always_declare_return_types
  buildContainer(Widget child) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 52.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: standardPadding),
        child: child,
      ),
    );
  }
}
