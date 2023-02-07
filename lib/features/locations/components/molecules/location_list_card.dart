import 'package:flutter/material.dart';

import '../../../../pages/location_page.dart';
import '../../models/location.dart';

class LocationListCard extends StatelessWidget {
  final Location currentLocation;

  const LocationListCard(this.currentLocation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.home, size: 40),
              title: Text(currentLocation.name),
              subtitle: Text(
                  '${currentLocation.price_per_night}€ - ${currentLocation.stripeProductId}'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationPage(currentLocation)))),
        ],
      ),
    );
  }
}
