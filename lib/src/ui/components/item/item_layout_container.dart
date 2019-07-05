import 'package:flutter/material.dart';
import '../../../constants/layout.dart' show standardHorizontalPadding;

class ItemLayoutContainer extends StatelessWidget {
  const ItemLayoutContainer(this.child, {this.onTap});

  final Function onTap;
  final dynamic child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
//      color: Colors.white,
      child: InkWell(
        onTap: onTap is Function ? onTap : null,
        child: buildContainer(child),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      color: Colors.white,
      constraints: const BoxConstraints(
        minHeight: 72.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: standardHorizontalPadding),
        child: child,
      ),
    );
  }
}
