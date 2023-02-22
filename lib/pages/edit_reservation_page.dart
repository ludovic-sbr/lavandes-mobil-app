import 'package:flutter/material.dart';

import '../features/reservations/components/organisms/edit_reservation_form.dart';
import '../features/reservations/models/reservation.dart';

class EditReservationPage extends StatelessWidget {
  final Reservation currentReservation;

  EditReservationPage(this.currentReservation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier ${currentReservation.reservation_key}'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: EditReservationForm(currentReservation),
      )),
    );
  }
}
