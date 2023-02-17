import 'package:flutter/material.dart';
import 'package:mobilapp/features/locations/components/organisms/location_detail.dart';

import '../features/locations/models/location.dart';

class LocationPage extends StatelessWidget {
  final Location currentLocation;

  LocationPage(this.currentLocation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location - ${String.fromCharCodes(Runes(currentLocation.name))}'),
      ),
      body: LocationDetail(currentLocation),
    );
  }
}
