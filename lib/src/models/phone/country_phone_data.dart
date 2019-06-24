class CountryPhoneData {
  CountryPhoneData({this.countryId,
    this.code,
    this.name,
    this.lengths,
    this.example,
    this.numberPattern});

  CountryPhoneData.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    code = json['code'];
    name = json['name'];
    lengths = json['lengths'].cast<int>();
    example = json['example'];
    numberPattern = json['numberPattern'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryId'] = countryId;
    data['code'] = code;
    data['name'] = name;
    data['lengths'] = lengths;
    data['example'] = example;
    data['numberPattern'] = numberPattern;
    return data;
  }

  String countryId;

  int code;
  String name;
  List<int> lengths;
  int example;
  String numberPattern;
}

