import 'button_model.dart';
import 'item_model.dart';
import 'note_model.dart';
import 'property_model.dart';

class ScreenModel {
  String _path;
  String _value;
  List<dynamic> _components;

  ScreenModel.fromJson(Map<String, dynamic> json) {
    _path = json['path'];
    _value = json['value'];
    _components = json['components'] is List
        ? json['components'].map((dynamic component) {
            switch (component['component']) {
              case 'button':
                return ButtonModel.fromJson(component);
              case 'item':
                return ItemModel.fromJson(component);
              case 'note':
                return NoteModel.fromJson(component);
              case 'property':
                return PropertyModel.fromJson(component);
              default:
                return null;
            }
          }).toList()
        : <dynamic>[];
  }

  String get path => _path;
  String get value => _value;
  List<dynamic> get components => _components;
}
