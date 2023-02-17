import 'package:flutter/material.dart';

import '../features/locations/components/organisms/create_location_form.dart';

class CreateLocationPage extends StatelessWidget {
  CreateLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une location'),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CreateLocationForm(),
      )),
    );
  }
}
