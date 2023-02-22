import 'package:flutter/material.dart';

import '../../models/reservation.dart';

class ReservationDetail extends StatelessWidget {
  final Reservation currentReservation;

  ReservationDetail(this.currentReservation, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.data_object),
          title: Text('Id de base de données'),
          subtitle: Text(currentReservation.id.toString()),
        ),
        ListTile(
          leading: Icon(Icons.numbers),
          title: Text('Numéro'),
          subtitle: Text(currentReservation.reservation_key),
        ),
        ListTile(
          leading: Icon(Icons.hourglass_bottom),
          title: Text('Statut'),
          subtitle: Text(currentReservation.status == ReservationStatusEnum.COMPLETE ? 'Finalisée' : currentReservation.status == ReservationStatusEnum.CANCELED ? 'Annulée' : 'En attente de paiement'),
        ),
        ListTile(
          leading: Icon(Icons.perm_identity),
          title: Text('Vacancier'),
          subtitle: Text('${currentReservation.user.firstname} ${currentReservation.user.lastname} (${currentReservation.user.id})'),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Location'),
          subtitle: Text('${currentReservation.location.name} (${currentReservation.location.id})'),
        ),
        ListTile(
          leading: Icon(Icons.credit_card),
          title: Text('Id stripe'),
          subtitle: Text(currentReservation.stripe_session_id != null ? currentReservation.stripe_session_id! : 'Aucun.'),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Nombres d\'adultes'),
          subtitle: Text('${currentReservation.adult_nbr}'),
        ),
        ListTile(
          leading: Icon(Icons.emoji_people),
          title: Text('Nombres d\'enfants'),
          subtitle: Text('${currentReservation.child_nbr}'),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Nombres d\'animaux'),
          subtitle: Text('${currentReservation.animal_nbr}'),
        ),
        ListTile(
          leading: Icon(Icons.car_rental),
          title: Text('Nombres de véhicules'),
          subtitle: Text('${currentReservation.vehicle_nbr}'),
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: Text('Période'),
          subtitle: Text('Du ${currentReservation.from} au ${currentReservation.to}'),
        ),
        ListTile(
          leading: Icon(Icons.euro),
          title: Text('Prix total'),
          subtitle: Text('${currentReservation.total_price}€'),
        ),
        ListTile(
          leading: Icon(Icons.night_shelter),
          title: Text('Nombre de nuits'),
          subtitle: Text('${currentReservation.night_number}'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Moyen de contact'),
          subtitle: Text(currentReservation.user_contact != null ? currentReservation.user_contact! : 'Aucun.'),
        ),
        ListTile(
          leading: Icon(Icons.comment),
          title: Text('Commentaire client'),
          subtitle: Text(currentReservation.user_comment != null ? currentReservation.user_comment! : 'Aucun.'),
        ),
      ],
    ));
  }
}
