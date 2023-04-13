class Address {
  final String postalCode;
  final String state;
  final String city;
  final String? district;
  final String? street;

  Address(
      {required this.postalCode,
      required this.state,
      required this.city,
      required this.district,
      required this.street});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        postalCode: json['cep'] as String,
        state: json['estado'] as String,
        city: json['cidade'] as String,
        district: json['bairro'] as String?,
        street: json['rua'] as String?);
  }
}
