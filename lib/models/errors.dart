class Error {
  String error;
  String message;
  Error({required this.error, required this.message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(error: json['error'] as String, message: json['message'] as String);
  }
}
