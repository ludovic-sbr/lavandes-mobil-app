import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../common/components/error_displayer.dart';
import '../../../../pages/edit_reservation_page.dart';
import '../../../../pages/reservation_page.dart';
import '../../api.dart';
import '../../models/reservation.dart';

class ReservationListCard extends StatelessWidget {
  final Reservation currentReservation;
  final Function refreshData;

  const ReservationListCard(this.currentReservation, this.refreshData,
      {super.key});

  dynamic handleDelete(BuildContext context, [bool mounted = true]) async {
    Response res = await ReservationApi().deleteById(currentReservation.id);

    if (res.statusCode != 200 && mounted) {
      return ScaffoldMessenger.of(context).showSnackBar(
          ErrorDisplayer.buildErrorSnackbar(context, jsonDecode(utf8.decode(res.bodyBytes))['message'])
      );
    }

    if (mounted) refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: currentReservation.status ==
                ReservationStatusEnum.COMPLETE
                ? Icon(Icons.verified)
                : currentReservation.status == ReservationStatusEnum.CANCELED
                ? Icon(Icons.cancel)
                : Icon(Icons.payment),
            title: Text(
                '${currentReservation.reservation_key} - ${currentReservation.user.firstname} ${currentReservation.user.lastname}'),
            subtitle: currentReservation.status ==
                ReservationStatusEnum.COMPLETE
                ? Text('Finalisée')
                : currentReservation.status == ReservationStatusEnum.CANCELED
                ? Text('Annulée')
                : Text('En attente de paiement'),
            tileColor: currentReservation.status ==
                    ReservationStatusEnum.COMPLETE
                ? Colors.green[050]
                : currentReservation.status == ReservationStatusEnum.CANCELED
                    ? Colors.red[050]
                    : null,
            trailing: TextButton(
                child: Icon(Icons.add, color: Colors.grey),
                onPressed: () => {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton(
                                        child: Icon(Icons.remove_red_eye,
                                            color: Colors.grey),
                                        onPressed: () => {
                                              Navigator.pop(context),
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          ReservationPage(
                                                              currentReservation))),
                                            }),
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) =>
                                                    EditReservationPage(
                                                        currentReservation)))
                                            .then((_) => refreshData()),
                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.blueGrey),
                                    ),
                                    TextButton(
                                      child: Icon(Icons.delete_forever,
                                          color: Colors.red),
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        handleDelete(context)
                                      },
                                    ),
                                  ],
                                ));
                          })
                    }),
          ),
        ],
      ),
    );
  }
}
