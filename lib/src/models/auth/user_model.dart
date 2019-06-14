class UserModel {
  UserModel({String phone}) {
    _phone = phone;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    _phone = json['phone_number'];
  }

  String _phone;

  String get phone => _phone;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['phone_number'] = _phone;
    return json;
  }
}
