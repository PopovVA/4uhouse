class CountryPhoneData {
  CountryPhoneData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _countryName = json['countryName'];
    _countryCode = json['countryCode'];
    _flag = json['flag'];
    _example = json['example'];
    _mask = json['mask'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'countryName': countryName,
      'countryCode': countryCode,
      'flag': flag,
      'example': example,
      'mask': mask,
    };
  }

  String _id;
  String _countryName;
  bool _countryCode;
  String _flag;
  String _example;
  String _mask;

  String get id => _id;

  String get countryName => _countryName;

  bool get countryCode => _countryCode;

  String get flag => _flag;

  String get example => _example;

  String get mask => _mask;
}
