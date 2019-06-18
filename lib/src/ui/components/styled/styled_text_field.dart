import 'package:flutter/material.dart';

import '../../../pallete.dart' show primaryColor;

class StyledTextField extends StatelessWidget {
  const StyledTextField({
    this.autofocus = false,
    this.borderColor = primaryColor,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.textAlign = TextAlign.left,
  });

  final Color borderColor;

  // extension
  final bool autofocus;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLength;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          hintStyle: const TextStyle(color: Color(0x8a000000), fontSize: 16.0),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 2.0, color: const Color.fromRGBO(175, 173, 173, 0.4))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: borderColor))),
      maxLength: maxLength,
      style: const TextStyle(color: Color(0xDD000000)),
      textAlign: textAlign,
    );
  }
}
