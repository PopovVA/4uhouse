import 'package:flutter/material.dart';
import '../../../constants/layout.dart' show standardPadding;

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
