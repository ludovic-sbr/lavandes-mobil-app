import 'dart:convert';
import 'package:http/http.dart';
import '../../common/services/index.dart';
import './service.dart';

class AuthenticationApi {
  Future<Response> login(Map<String, dynamic> credentials) async {
    var res = await post(
        Uri.parse('$apiUrl/authenticate/admin'),
        headers: await getHeaders(),
        body: jsonEncode({
          'email': credentials['email'],
          'password': credentials['password'],
          'google_id': credentials['google_id']
        })
    );

    if (res.statusCode == 200) {
      String token = json.decode(res.body)['token'];

      AuthService().loginUser(token);
    }

    return res;
  }
}

