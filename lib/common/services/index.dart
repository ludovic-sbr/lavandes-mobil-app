import 'package:mobilapp/common/services/secure_storage.dart';

Future<Map<String, String>> getHeaders() async {
  String token = await secureStorage.readSecureData('token');

  return {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json; charset=utf-8',
  };
}

String apiUrl = 'https://api.camping-lavandes.com/api';
