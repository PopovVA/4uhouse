import 'component_model.dart';

class NoteModel extends ComponentModel {
  String _value;

	NoteModel.fromJson(Map<String, dynamic> json)
		:	_value = json['value'],
			super.fromJson(json['component']);

	dynamic get value => _value;
}