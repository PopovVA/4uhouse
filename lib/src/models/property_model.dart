import 'component_model.dart';

class PropertyModel extends ComponentModel {
  String _id;
  String _picture;
  String _statusValue;
  String _statusColor;
  String _mainValue1;
  String _mainValue2;
  String _addInfo1;
  String _addInfo2;

  PropertyModel.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _picture = json['picture'],
        _statusValue = json['statusValue'],
        _statusColor = json['statusColor'],
        _mainValue1 = json['mainValue1'],
        _mainValue2 = json['mainValue2'],
        _addInfo1 = json['addInfo1'],
        _addInfo2 = json['addInfo2'],
        super.fromJson(json['component']);

  String get id => _id;
  String get picture => _picture;
  String get statusValue => _statusValue;
  String get statusColor => _statusColor;
  String get mainValue1 => _mainValue1;
  String get mainValue2 => _mainValue2;
  String get addInfo1 => _addInfo1;
  String get addInfo2 => _addInfo2;
}
