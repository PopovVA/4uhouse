import 'package:flutter/material.dart';

class MoneyPicker extends StatelessWidget {
  final TextEditingController _controller;
  
  MoneyPicker(this._controller);
	
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Cost, \$/month'
      ),
	    keyboardType: TextInputType.number,
	    style: Theme.of(context).textTheme.subhead,
      textAlign: TextAlign.center,
	    cursorColor: Colors.white,
    );
  }
}

