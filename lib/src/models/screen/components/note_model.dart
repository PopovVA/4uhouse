import 'component_model.dart';

class NoteModel extends ComponentModel {
  NoteModel.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _value = json['value'],
        _color = json['color'],
        super.fromJson(json['component']);

  String _id;
  String _value;
  int _color;

  dynamic get value => _value;

  String get id => _id;

  int get color => _color;
}
