import 'dart:convert';

import 'package:http/http.dart';

import '../../common/services/index.dart';
import 'models/reservation.dart';

class ReservationApi {
  Future<List<Reservation>> getAll() async {
    var res = await get(
      Uri.parse('$apiUrl/reservation'),
      headers: getHeaders(),
    );

    if (res.statusCode != 200) {
      throw json.decode(res.body)['message'].toString();
    }

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['reservations'];

    return data
        .map<Reservation>((reservation) => Reservation.fromJson(reservation))
        .toList();
  }

  Future<Reservation> getById(int reservationId) async {
    var res = await get(
      Uri.parse('$apiUrl/reservation/$reservationId'),
      headers: getHeaders(),
    );

    if (res.statusCode != 200) {
      throw json.decode(res.body)['message'].toString();
    }

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['reservation'];

    return Reservation.fromJson(data);
  }

  Future<Response> create(Map<String, dynamic> reservation) async {
    var res = await post(
        Uri.parse('$apiUrl/reservation'),
        headers: getHeaders(),
        body: jsonEncode({
          'user_id': reservation['user_id'],
          'location_id': reservation['location_id'],
          'adult_nbr': reservation['adult_nbr'],
          'child_nbr': reservation['child_nbr'],
          'animal_nbr': reservation['animal_nbr'],
          'vehicle_nbr': reservation['vehicle_nbr'],
          'from': reservation['from'],
          'to': reservation['to'],
          'status': reservation['status'],
          'user_contact': reservation['user_contact'],
          'user_comment': reservation['user_comment'],
        })
    );

    return res;
  }

  Future<Response> edit(int reservationId, Map<String, dynamic> reservation) async {
    var res = patch(
      Uri.parse('$apiUrl/reservation/$reservationId'),
      headers: getHeaders(),
      body: jsonEncode({
        'user_id': reservation['user_id'],
        'location_id': reservation['location_id'],
        'adult_nbr': reservation['adult_nbr'],
        'child_nbr': reservation['child_nbr'],
        'animal_nbr': reservation['animal_nbr'],
        'vehicle_nbr': reservation['vehicle_nbr'],
        'from': reservation['from'],
        'to': reservation['to'],
        'status': reservation['status'],
        'user_contact': reservation['user_contact'],
        'user_comment': reservation['user_comment'],
      })
    );

    return res;
  }

  Future<Response> deleteById(int reservationId) async {
    var res = await delete(
      Uri.parse('$apiUrl/reservation/$reservationId'),
      headers: getHeaders(),
    );

    return res;
  }
}
