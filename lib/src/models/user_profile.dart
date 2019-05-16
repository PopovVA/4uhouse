class UserProfile {
  UserProfile({this.name, this.phone, this.email});

  String name, phone, email;

  Map<String, String> toMap() {
    Map<String, String> data = Map();
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }

  UserProfile.fromMap(Map<String, String> map) {
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
  }
}
