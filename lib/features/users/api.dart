import 'dart:convert';

import 'package:http/http.dart';

import '../../common/services/index.dart';
import 'models/user.dart';

class UserApi {
  Future<List<User>> getAll() async {
    var res = await get(
      Uri.parse('$apiUrl/user'),
      headers: getHeaders(),
    );

    if (res.statusCode != 200) {
      throw json.decode(res.body)['message'].toString();
    }

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['users'];

    return data
        .map<User>((user) => User.fromJson(user))
        .toList();
  }
}