import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/reservation.dart';

class ReservationListCard extends StatelessWidget {
  final Reservation currentReservation;

  const ReservationListCard(this.currentReservation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.menu_book, size: 40),
            title: Text(
                '${currentReservation.reservation_key} - ${currentReservation.user.firstname} ${currentReservation.user.lastname}'),
            subtitle: Text(
                'Du ${DateFormat('dd/MM/y').format(DateTime.parse(currentReservation.from))} au ${DateFormat('dd/MM/y').format(DateTime.parse(currentReservation.to))}'),
          ),
        ],
      ),
    );
  }
}
