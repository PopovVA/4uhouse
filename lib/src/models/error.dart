class ErrorMessage {
  ErrorMessage({this.message});

  ErrorMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  String message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
