import 'package:flutter/material.dart';
import '../../models/note_model.dart';

class Note extends StatelessWidget {
  Note(this.note);

  final NoteModel note;

  static const int HIGHLIGHT_COLOR = 0xFFdeff0000;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 54.0,
      padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
      child: Text(
        note.value,
        style: TextStyle(
          fontSize: 16.0,
          color: Color(0xFFdeff0000),
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0xFFb5ffc5c5),
        border: Border(
          left: BorderSide(
            color: Color(0xFFd24444),
            width: 4.0,
          ),
          bottom: BorderSide(
            color: Color(0xFFecc3c3),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF40000000),
            spreadRadius: 4.0,
            blurRadius: 5.0,
          ),
        ],
      ),
    );
  }
}
