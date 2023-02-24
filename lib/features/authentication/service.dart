import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../common/services/secure_storage.dart';

class AuthService {
  Future<bool> isLogged() async {
    String token = await secureStorage.readSecureData('token');

    return token != '' && !_isExpired(token);
  }

  bool _isExpired(String token) {
    Map<String, dynamic> claims = Jwt.parseJwt(token);
    return claims['exp'] < DateTime.now().millisecondsSinceEpoch / 1000;
  }

  void loginUser(String token) {
    return secureStorage.writeSecureData('token', token);
  }

  Future<void> logoutUser() {
    return secureStorage.deleteSecureData('token');
  }
}