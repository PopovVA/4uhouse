import 'package:flutter/material.dart';
import '../../models/screen/components/note_model.dart' show NoteModel;

class Note extends StatelessWidget {
  Note(NoteModel note)
      // ignore: prefer_initializing_formals
      : note = note,
        id = note.id,
        color = note.color;

  final NoteModel note;
  final String id;
  final int color;

  static const int HIGHLIGHT_COLOR = 0xFFdeff0000;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(color),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 54.0,
      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
      child: Text(
        note.value,
        style: const TextStyle(
          fontSize: 16.0,
          color: Color(0xFFdeff0000),
        ),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFb5ffc5c5),
        border: Border(
          left: BorderSide(
            color: const Color(0xFFd24444),
            width: 4.0,
          ),
          bottom: BorderSide(
            color: const Color(0xFFecc3c3),
            width: 1.0,
          ),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF40000000),
            spreadRadius: 4.0,
            blurRadius: 5.0,
          ),
        ],
      ),
    );
  }
}
