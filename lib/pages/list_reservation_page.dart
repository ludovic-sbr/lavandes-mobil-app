import 'package:flutter/material.dart';
import 'package:mobilapp/features/reservations/components/organisms/list_reservation.dart';

class ListReservationPage extends StatelessWidget {
  static const int routeId = 1;
  static const String routeName = '/reservation';

  ListReservationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListReservation();
  }
}
