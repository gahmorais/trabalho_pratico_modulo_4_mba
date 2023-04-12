import 'dart:convert';

import 'package:app/models/errors.dart';
import "package:http/http.dart" as http;
import 'package:app/models/address.dart';

class PostalCodeService {
  Future<Address> getAddress(String postalCode) async {
    Map<String, dynamic> parameters = {"cep": postalCode};
    final url = Uri.http("192.168.0.161:3000", "api/v1/cep", parameters);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Address.fromJson(json);
    }
    final jsonError = jsonDecode(response.body);
    throw Error.fromJson(jsonError);
  }
}
