class UserProfile {
  UserProfile.fromJson(Map<String, dynamic> json) {
    _sub = json['sub'];
    _email = json['email'];
    _emailVerified = json['email_verified'];
    _preferredUsername = json['preferred_username'];
  }

  String _sub;
  String _email;
  bool _emailVerified;
  String _preferredUsername;

  String get sub => _sub;

  String get email => _email;

  bool get emailVerified => _emailVerified;

  String get preferredUsername => _preferredUsername;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sub': sub,
      'email_verified': emailVerified,
      'preferred_username': preferredUsername,
      'email': email,
    };
  }
}
