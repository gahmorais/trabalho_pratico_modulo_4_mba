class CepExpection {
  String error;
  String message;
  CepExpection({required this.error, required this.message});

  factory CepExpection.fromJson(Map<String, dynamic> json) {
    return CepExpection(error: json['error'] as String, message: json['message'] as String);
  }
}
