import 'package:flutter/material.dart';
import 'package:mobilapp/features/reservations/components/organisms/list_reservation.dart';

class ListReservationPage extends StatefulWidget {
  static const int routeId = 1;
  static const String routeName = '/reservation';

  const ListReservationPage({Key? key}) : super(key: key);

  @override
  State<ListReservationPage> createState() => _ListReservationPageState();
}

class _ListReservationPageState extends State<ListReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Column(children: <Widget>[
            SizedBox(
              child: ListReservation(),
            ),
          ]),
        ),
      ),
    );
  }
}
