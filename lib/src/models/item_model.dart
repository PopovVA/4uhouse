import 'component_model.dart';

class ItemModel extends ComponentModel {
	String _id;
	String _key;
	String _picture;
	bool _isTransition;
	bool _isInput;
	String _typeValue;
	dynamic _value;

	// date specific props
	int _min;
	int _max;

	ItemModel.fromJson(Map<String, dynamic> json)
		: _id = json['id'],
  		_key = json['key'],
			_picture = json['picture'],
			_isTransition = json['isTransition'],
			_isInput = json['isInput'],
			_typeValue = json['typeValue'],
			_value = json['value'],

			_min = json['min'],
			_max = json['max'],
			super.fromJson(json['component']);
	
	String get id => _id;
	String get key => _key;
	String get picture => _picture;
	bool get isTransition => _isTransition;
	bool get isInput => _isInput;
	String get typeValue => _typeValue;
	dynamic get value {
		return
			((typeValue == 'money') && (_value is int))
				? (_value / 100)
				: _value;
	}
	
	set value(value) {
		if (value is bool) {
			_value = value;
		}
	}

	// date specific props
	int get min => _min;
	int get max => _max;
}
