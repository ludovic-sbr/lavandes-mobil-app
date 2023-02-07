import 'dart:convert';

import 'package:http/http.dart';

import '../../common/services/index.dart';
import 'models/location.dart';

class LocationApi {
  final apiUrl = 'https://api.camping-lavandes.com/api/location';

  Future<List<Location>> getAll() async {
    var res = await get(
      Uri.parse(apiUrl),
      headers: getHeaders(),
    );

    if (res.statusCode != 200)
      throw json.decode(res.body)['message'].toString();

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['locations'];

    return data
        .map<Location>((location) => Location.fromJson(location))
        .toList();
  }
}
