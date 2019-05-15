import 'component_model.dart';

class ButtonModel extends ComponentModel {
  String _id;
  String _key;
  bool _isAble;
  dynamic _value;

  ButtonModel.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _key = json['key'],
        _isAble = json['isAble'],
        _value = json['value'],
        super.fromJson(json['component']);

  String get id => _id;
  String get key => _key;
  bool get isAble => _isAble;
  dynamic get value => _value;
}
