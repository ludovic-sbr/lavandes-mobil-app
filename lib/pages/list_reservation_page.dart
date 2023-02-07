import 'package:flutter/material.dart';
import 'package:mobilapp/features/reservations/components/organisms/list_reservation.dart';

class ListReservationPage extends StatefulWidget {
  const ListReservationPage({Key? key}) : super(key: key);

  @override
  State<ListReservationPage> createState() => _ListReservationPageState();
}

class _ListReservationPageState extends State<ListReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            child: ListReservation(),
          ),
        ]),
      ),
    );
  }
}
