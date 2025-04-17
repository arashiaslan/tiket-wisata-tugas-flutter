import 'package:http/http.dart' as http;
class AuthRemoteDatasources {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://tiket.febryann.my.id/api/login'),
      body: {'email': email, 'password': password},
    );
    return{};
  }
}