class UserProfile {
  UserProfile({this.name, this.phone, this.email});

  final String name, phone, email;

  Map<String, String> toMap() {
    Map<String, String> data;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
