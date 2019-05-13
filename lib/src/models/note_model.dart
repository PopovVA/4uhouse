import 'component_model.dart';

class NoteModel extends ComponentModel {
  String _id;
  String _value;

  NoteModel.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _value = json['value'],
        super.fromJson(json['component']);

  dynamic get value => _value;
  String get id => _id;
}
