import 'package:flutter/material.dart';

import '../features/reservations/components/organisms/create_reservation_form.dart';

class CreateReservationPage extends StatelessWidget {
  CreateReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une réservation'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CreateReservationForm(),
      )),
    );
  }
}
