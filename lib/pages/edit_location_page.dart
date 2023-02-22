import 'package:flutter/material.dart';
import 'package:mobilapp/features/locations/components/organisms/edit_location_form.dart';

import '../features/locations/models/location.dart';

class EditLocationPage extends StatelessWidget {
  final Location currentLocation;

  EditLocationPage(this.currentLocation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editer une location'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: EditLocationForm(currentLocation),
      )),
    );
  }
}
