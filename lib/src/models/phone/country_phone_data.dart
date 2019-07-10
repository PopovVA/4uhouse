class CountryPhoneData {
  CountryPhoneData({this.phoneCountryId,
      this.code,
      this.name,
      this.lengths,
      this.example,
      this.numberPattern,
      this.flag});

  CountryPhoneData.fromJson(Map<String, dynamic> json) {
    phoneCountryId = json['phoneCountryId'];
    code = json['code'];
    name = json['name'];
    lengths = json['lengths'].cast<int>();
    example = json['example'];
    numberPattern = json['numberPattern'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneCountryId'] = phoneCountryId;
    data['code'] = code;
    data['name'] = name;
    data['lengths'] = lengths;
    data['example'] = example;
    data['numberPattern'] = numberPattern;
    data['flag'] = flag;
    return data;
  }

  String phoneCountryId;
  int code;
  String name;
  List<int> lengths;
  int example;
  String numberPattern;
  String flag;
}
