import 'package:flutter/material.dart';

enum LocationsOptionsEnum {
  parking,
  kitchen,
  wifi,
  sanitary,
  heater,
  air_conditioner,
  terrace,
  barbecue
}

class LocationListOptions extends StatelessWidget {
  final bool parking;
  final bool kitchen;
  final bool wifi;
  final bool sanitary;
  final bool heater;
  final bool air_conditioner;
  final bool terrace;
  final bool barbecue;

  const LocationListOptions(
      this.parking,
      this.kitchen,
      this.wifi,
      this.sanitary,
      this.heater,
      this.air_conditioner,
      this.terrace,
      this.barbecue,
      {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (parking) Icon(Icons.local_parking_sharp),
        if (kitchen) Icon(Icons.kitchen),
        if (wifi) Icon(Icons.wifi),
        if (sanitary) Icon(Icons.bathtub),
        if (heater) Icon(Icons.local_fire_department),
        if (air_conditioner) Icon(Icons.air_sharp),
        if (terrace) Icon(Icons.brightness_6),
        if (barbecue) Icon(Icons.outdoor_grill),
      ]
    );
  }
}
