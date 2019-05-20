class UserProfile {
  UserProfile({this.name, this.phone, this.email});

  UserProfile.fromMap(Map<String, String> map) {
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
  }

  String name, phone, email;

  Map<String, String> toMap() {
    // ignore: prefer_collection_literals
    final Map<String, String> data = Map<String, String>();
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
