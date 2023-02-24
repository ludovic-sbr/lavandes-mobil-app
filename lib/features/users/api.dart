import 'dart:convert';

import 'package:http/http.dart';

import '../../common/services/index.dart';
import 'models/user.dart';

class UserApi {
  Future<List<User>> getAll() async {
    var res = await get(
      Uri.parse('$apiUrl/user'),
      headers: await getHeaders(),
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

  Future<User> getMyself() async {
    var res = await get(
      Uri.parse('$apiUrl/user/me'),
      headers: await getHeaders(),
    );

    if (res.statusCode != 200) {
      throw json.decode(res.body)['message'].toString();
    }

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['user'];

    return User.fromJson(data);
  }

  Future<Response> edit(int userId, Map<String, dynamic> reservation) async {
    var res = patch(
        Uri.parse('$apiUrl/user/$userId'),
        headers: await getHeaders(),
        body: jsonEncode({
          'firstname': reservation['firstname'],
          'lastname': reservation['lastname'],
          'email': reservation['email'],
          'roleName': reservation['roleName'],
        })
    );

    return res;
  }

  Future<Response> deleteById(int userId) async {
    var res = await delete(
      Uri.parse('$apiUrl/user/$userId'),
      headers: await getHeaders(),
    );

    return res;
  }
}