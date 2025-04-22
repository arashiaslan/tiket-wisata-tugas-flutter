import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {

  static const tokenKey = 'token';

  Future<void> saveToken(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(tokenKey, token);
  }

  Future<String?> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(tokenKey);
  }
  
  Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(tokenKey);
  }
}