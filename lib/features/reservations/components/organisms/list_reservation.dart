import 'package:flutter/material.dart';
import 'package:mobilapp/common/components/error_displayer.dart';
import 'package:mobilapp/features/reservations/components/molecules/reservation_list_card.dart';
import 'package:mobilapp/features/reservations/models/reservation.dart';

import '../../../../common/components/loader.dart';
import '../../api.dart';

class ListReservation extends StatefulWidget {
  const ListReservation({Key? key}) : super(key: key);

  @override
  State<ListReservation> createState() => _ListReservationState();
}

class _ListReservationState extends State<ListReservation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
      future: ReservationApi().getAll(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Reservation>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (ctx, index) {
                return ReservationListCard(snapshot.data![index]);
              },
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            ErrorDisplayer(snapshot.error as String),
          ];
        } else {
          children = <Widget>[
            Loader(),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
