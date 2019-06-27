import 'package:flutter/material.dart';
import '../../../constants/layout.dart' show standardHorizontalPadding;

class ItemLayoutContainer extends StatelessWidget {
  const ItemLayoutContainer(this.child, {this.onTap});

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

  Widget buildContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 72.0,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(
                    color: Color.fromRGBO(249, 171, 60, 1),
                    width: 4.0,
                    style: BorderStyle.solid))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: standardHorizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
