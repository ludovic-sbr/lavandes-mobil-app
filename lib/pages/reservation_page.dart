import 'package:flutter/material.dart';

import '../features/reservations/components/organisms/reservation_detail.dart';
import '../features/reservations/models/reservation.dart';

class ReservationPage extends StatelessWidget {
  final Reservation currentReservation;

  ReservationPage(this.currentReservation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Reservation - ${String.fromCharCodes(Runes(currentReservation.reservation_key))}'),
      ),
      body: ReservationDetail(currentReservation),
    );
  }
}
