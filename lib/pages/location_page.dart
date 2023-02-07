import 'package:flutter/material.dart';

import '../features/locations/models/location.dart';

class LocationPage extends StatelessWidget {
  final Location currentLocation;

  const LocationPage(this.currentLocation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Location - ${currentLocation.name}'),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
              image: NetworkImage(currentLocation.image.publicUrl),
            ),
            ListTile(
              title: Text('Id de base de données'),
              subtitle: Text(currentLocation.id.toString()),
            ),
            ListTile(
              title: Text('Nom'),
              subtitle: Text(currentLocation.name),
            ),
            ListTile(
              title: Text('Description'),
              subtitle: Text(currentLocation.description),
            ),
            ListTile(
              title: Text('Prix par nuit'),
              subtitle: Text('${currentLocation.price_per_night}€'),
            ),
            ListTile(
              title: Text('Capacité'),
              subtitle: Text('${currentLocation.max_persons} personnes'),
            ),
            ListTile(
              title: Text('Surface'),
              subtitle: Text('${currentLocation.surface}m²'),
            ),
            ListTile(
              title: Text('Nombre de chambres'),
              subtitle: Text('${currentLocation.bedrooms} chambres'),
            ),
            ListTile(
              title: Text('Options'),
              subtitle: Text('Liste des options ici.'),
            ),
          ],
        )));
  }
}
