class CountryPhoneData {
  CountryPhoneData(
      {this.countryId,
      this.code,
      this.name,
      this.length,
      this.example,
      this.numberPattern});

  CountryPhoneData.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    code = json['code'];
    name = json['name'];
    length = json['length'].cast<int>();
    example = json['example'];
    numberPattern = json['numberPattern'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryId'] = countryId;
    data['code'] = code;
    data['name'] = name;
    data['length'] = length;
    data['example'] = example;
    data['numberPattern'] = numberPattern;
    return data;
  }

  String countryId;

  int code;
  String name;
  List<int> length;
  int example;
  String numberPattern;
}
