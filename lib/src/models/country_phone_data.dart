
class CountryPhoneDataResponse {
  CountryPhoneDataResponse(
      {this.creationDate, this.topCountryPhonesData, this.countryPhonesData});

  CountryPhoneDataResponse.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate']!=null?json['creationDate']:null;
    if (json['topCountryPhonesData'] != null) {
      topCountryPhonesData = <CountryPhoneData>[];
      json['topCountryPhonesData'].forEach((dynamic v) {
        topCountryPhonesData.add(CountryPhoneData.fromJson(v));
      });
    }
    if (json['countryPhonesData'] != null) {
      countryPhonesData = <CountryPhoneData>[];
      json['countryPhonesData'].forEach((dynamic v) {
        countryPhonesData.add(CountryPhoneData.fromJson(v));
      });
    }
  }

  int creationDate;
  List<CountryPhoneData> topCountryPhonesData;
  List<CountryPhoneData> countryPhonesData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creationDate'] = creationDate;
    if (topCountryPhonesData != null) {
      data['topCountryPhonesData'] =
          topCountryPhonesData.map((dynamic v) => v.toJson()).toList();
    }
    if (countryPhonesData != null) {
      data['countryPhonesData'] =
          countryPhonesData.map((dynamic v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryPhoneData {
  CountryPhoneData({this.countryId,
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

