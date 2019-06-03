class CountryPhoneData {
  CountryPhoneData({countryId, code, name, length, example, numberPattern});

  CountryPhoneData.fromJson(Map<String, dynamic> json) {
    _countryId = json['countryId'];
    _code = json['code'];
    _name = json['name'];
    _length = json['length'].cast<int>();
    _example = json['example'];
    _numberPattern = json['numberPattern'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryId'] = countryId;
    data['code'] = code;
    data['name'] = name;
    data['length'] = length;
    data['example'] = example;
    data['numberPattern'] = numberPattern;
    return data;
  }

  String _countryId;

  String get countryId => _countryId;
  int _code;
  String _name;
  List<int> _length;
  int _example;
  String _numberPattern;

  int get code => _code;

  String get name => _name;

  List<int> get length => _length;

  int get example => _example;

  String get numberPattern => _numberPattern;
}
