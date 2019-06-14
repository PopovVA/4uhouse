class UserModel {
  UserModel({String phone}) {
    _phone = phone;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    _phone = json['phone'];
  }

  String _phone;

  String get phone => _phone;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = _phone;
    return data;
  }
}
