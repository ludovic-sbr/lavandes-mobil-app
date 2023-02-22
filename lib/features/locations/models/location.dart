import 'package:mobilapp/common/models/file.dart';

class Location {
  final int id;
  final String name;
  final File image;
  final String stripeProductId;
  final String description;
  final bool parking;
  final bool kitchen;
  final bool wifi;
  final bool sanitary;
  final bool heater;
  final bool air_conditioner;
  final bool terrace;
  final bool barbecue;
  final int surface;
  final int max_persons;
  final int price_per_night;
  final int bedrooms;
  final int slot_remaining;

  Location(
      {required this.id,
      required this.name,
      required this.image,
      required this.stripeProductId,
      required this.description,
      required this.parking,
      required this.kitchen,
      required this.wifi,
      required this.sanitary,
      required this.heater,
      required this.air_conditioner,
      required this.terrace,
      required this.barbecue,
      required this.surface,
      required this.max_persons,
      required this.price_per_night,
      required this.bedrooms,
      required this.slot_remaining});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as int,
      name: json['name'] as String,
      image: File.fromJson(json['image']),
      stripeProductId: json['stripeProductId'] as String,
      description: json['description'] as String,
      parking: json['parking'] as bool,
      kitchen: json['kitchen'] as bool,
      wifi: json['wifi'] as bool,
      sanitary: json['sanitary'] as bool,
      heater: json['heater'] as bool,
      air_conditioner: json['air_conditioner'] as bool,
      terrace: json['terrace'] as bool,
      barbecue: json['barbecue'] as bool,
      surface: json['surface'] as int,
      max_persons: json['max_persons'] as int,
      price_per_night: json['price_per_night'] as int,
      bedrooms: json['bedrooms'] as int,
      slot_remaining: json['slot_remaining'] as int,
    );
  }
}
