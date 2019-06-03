class ErrorMessage {
  ErrorMessage({message});

  ErrorMessage.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
  }

  String _message;

  String get message => _message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    return data;
  }
}
