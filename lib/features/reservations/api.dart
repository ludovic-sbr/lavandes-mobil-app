import 'dart:convert';

import 'package:http/http.dart';

import '../../common/services/index.dart';
import 'models/reservation.dart';

class ReservationApi {
  final apiUrl = 'https://api.camping-lavandes.com/api/reservation';

  Future<List<Reservation>> getAll() async {
    var res = await get(
      Uri.parse(apiUrl),
      headers: getHeaders(),
    );

    if (res.statusCode != 200)
      throw json.decode(res.body)['message'].toString();

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['reservations'];

    return data
        .map<Reservation>((reservation) => Reservation.fromJson(reservation))
        .toList();
  }
}
