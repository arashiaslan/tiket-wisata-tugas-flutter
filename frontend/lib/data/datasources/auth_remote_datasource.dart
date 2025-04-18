import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class AuthRemoteDatasource {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://tiket.febryann.my.id/api/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200 && data['token'] != null) {
      return {
        'token': data['token'],
        'user': UserModel.fromJson(data['user']),
      };
    } else {
      throw Exception(data['message'] ?? 'Failed to login');
    }
  }
}
