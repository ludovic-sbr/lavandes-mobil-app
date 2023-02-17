import 'package:flutter/material.dart';

import '../../models/location.dart';
import '../molecules/location_list_options.dart';

class LocationDetail extends StatelessWidget {
  final Location currentLocation;

  const LocationDetail(this.currentLocation, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(
          image: NetworkImage(currentLocation.image.publicUrl),
        ),
        ListTile(
          leading: Icon(Icons.perm_identity),
          title: Text('Nom'),
          subtitle: Text(currentLocation.name),
        ),
        ListTile(
          leading: Icon(Icons.data_object),
          title: Text('Id de base de données'),
          subtitle: Text(currentLocation.id.toString()),
        ),
        ListTile(
          leading: Icon(Icons.text_fields),
          title: Text('Description'),
          subtitle: Text(currentLocation.description),
        ),
        ListTile(
          leading: Icon(Icons.money),
          title: Text('Prix par nuit'),
          subtitle: Text('${currentLocation.price_per_night}€'),
        ),
        ListTile(
          leading: Icon(Icons.reduce_capacity),
          title: Text('Capacité'),
          subtitle: Text('${currentLocation.max_persons} personnes'),
        ),
        ListTile(
          leading: Icon(Icons.density_large),
          title: Text('Surface'),
          subtitle: Text('${currentLocation.surface}m²'),
        ),
        ListTile(
          leading: Icon(Icons.bed),
          title: Text('Nombre de chambres'),
          subtitle: Text('${currentLocation.bedrooms} chambres'),
        ),
        ListTile(
          leading: Icon(Icons.keyboard_option_key),
          title: Text('Options'),
          subtitle: LocationListOptions(
              currentLocation.parking,
              currentLocation.kitchen,
              currentLocation.wifi,
              currentLocation.sanitary,
              currentLocation.heater,
              currentLocation.air_conditioner,
              currentLocation.terrace,
              currentLocation.barbecue,
          ),
        ),
      ],
    ));
  }
}
