import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: const Text(
      'Add a property in 3 steps',
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(115, 115, 115, 1.0)),
    )));
  }
}
