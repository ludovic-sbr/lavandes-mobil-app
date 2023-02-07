import '../../locations/models/location.dart';
import '../../users/models/user.dart';

class Reservation {
  final int id;
  final User user;
  final Location location;
  final String reservation_key;
  final int adult_nbr;
  final int child_nbr;
  final int animal_nbr;
  final int vehicle_nbr;
  final String from;
  final String to;
  final int total_price;
  final int night_number;
  final String? stripe_session_id;
  final String status;
  final String? user_contact;
  final String? user_comment;

  Reservation(
      {required this.id,
      required this.user,
      required this.location,
      required this.reservation_key,
      required this.adult_nbr,
      required this.child_nbr,
      required this.animal_nbr,
      required this.vehicle_nbr,
      required this.from,
      required this.to,
      required this.total_price,
      required this.night_number,
      this.stripe_session_id,
      required this.status,
      this.user_comment,
      this.user_contact});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as int,
      user: User.fromJson(json['user']),
      location: Location.fromJson(json['location']),
      reservation_key: json['reservation_key'] as String,
      adult_nbr: json['adult_nbr'] as int,
      child_nbr: json['child_nbr'] as int,
      animal_nbr: json['animal_nbr'] as int,
      vehicle_nbr: json['vehicle_nbr'] as int,
      from: json['from'] as String,
      to: json['to'] as String,
      total_price: json['total_price'] as int,
      night_number: json['night_number'] as int,
      stripe_session_id: json['stripe_session_id'],
      status: json['status'] as String,
      user_comment: json['user_comment'],
      user_contact: json['user_contact'],
    );
  }
}
