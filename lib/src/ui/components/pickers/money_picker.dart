import 'package:flutter/material.dart';

class MoneyPicker extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MoneyPicker(this._controller);

  final TextEditingController _controller;


  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(hintText: 'Cost, \$/month'),
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.subhead,
      textAlign: TextAlign.center,
      cursorColor: Colors.white,
    );
  }
}
