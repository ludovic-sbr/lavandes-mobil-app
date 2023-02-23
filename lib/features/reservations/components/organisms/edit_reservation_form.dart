import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:mobilapp/features/users/api.dart';
import 'package:mobilapp/features/users/models/user.dart';

import '../../../../common/components/error_displayer.dart';
import '../../../locations/api.dart';
import '../../../locations/models/location.dart';
import '../../api.dart';
import '../../models/reservation.dart';

class EditReservationForm extends StatefulWidget {
  final Reservation currentReservation;

  EditReservationForm(this.currentReservation, {Key? key}) : super(key: key);

  @override
  State<EditReservationForm> createState() => _EditReservationFormState();
}

class _EditReservationFormState extends State<EditReservationForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController userController = TextEditingController(text: widget.currentReservation.user.id.toString());
  late TextEditingController locationController = TextEditingController(text: widget.currentReservation.location.id.toString());
  late TextEditingController adultNbrController = TextEditingController();
  late TextEditingController childNbrController = TextEditingController();
  late TextEditingController animalNbrController = TextEditingController();
  late TextEditingController vehicleNbrController = TextEditingController();
  late TextEditingController statusController = TextEditingController(text: widget.currentReservation.status.name);
  late TextEditingController userContactController = TextEditingController();
  late TextEditingController userCommentController = TextEditingController();
  late List<Location> locations = <Location>[];
  late List<User> users = <User>[];
  late DateTime from;
  late DateTime to;

  @override
  void dispose() {
    userController.dispose();
    locationController.dispose();
    adultNbrController.dispose();
    childNbrController.dispose();
    animalNbrController.dispose();
    vehicleNbrController.dispose();
    statusController.dispose();
    userContactController.dispose();
    userCommentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getLocations();
    getUsers();

    from = DateTime.now();
    to = DateTime.now();
  }

  void getUsers() async {
    List<User> userList = await UserApi().getAll();

    setState(() {
      users = userList;
    });
  }

  void getLocations() async {
    List<Location> locationList = await LocationApi().getAll();

    setState(() {
      locations = locationList;
    });
  }

  dynamic handleSubmit(BuildContext ctx) async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    Map<String, dynamic> data = {
      'user_id': userController.text,
      'location_id': locationController.text,
      'adult_nbr': adultNbrController.text,
      'child_nbr': childNbrController.text,
      'animal_nbr': animalNbrController.text,
      'vehicle_nbr': vehicleNbrController.text,
      'status': statusController.text,
      'user_contact': userContactController.text,
      'user_comment': userCommentController.text,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
    };

    Response res = await ReservationApi().edit(widget.currentReservation.id, data);

    if (res.statusCode != 200 && mounted) {
      return ScaffoldMessenger.of(context).showSnackBar(
          ErrorDisplayer.buildErrorSnackbar(context, jsonDecode(utf8.decode(res.bodyBytes))['message'])
      );
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Vacancier',
                icon: Icon(Icons.person),
              ),
              value: widget.currentReservation.user.id,
              onChanged: (newValue) {userController.text = newValue.toString();},
              items: <User>[...users].map<DropdownMenuItem<int>>((User value) {
                return DropdownMenuItem<int>(
                  value: value.id,
                  child: Text('${value.firstname} ${value.lastname}'),
                );
              }).toList(),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Location',
                icon: Icon(Icons.home),
              ),
              value: widget.currentReservation.location.id,
              onChanged: (newValue) {locationController.text = newValue.toString();},
              items: <Location>[...locations].map<DropdownMenuItem<int>>((Location value) {
                return DropdownMenuItem<int>(
                  value: value.id,
                  child: Text(value.name),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre d\'adultes',
                  icon: Icon(Icons.people)
              ),
              controller: adultNbrController
                ..text = widget.currentReservation.adult_nbr.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre d\'enfants',
                icon: Icon(Icons.emoji_people),
              ),
              controller: childNbrController
                ..text = widget.currentReservation.child_nbr.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre d\'animaux',
                icon: Icon(Icons.add),
              ),
              controller: animalNbrController
                ..text = widget.currentReservation.animal_nbr.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre de véhicules',
                icon: Icon(Icons.car_rental),
              ),
              controller: vehicleNbrController
                ..text = widget.currentReservation.vehicle_nbr.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Statut',
                icon: Icon(Icons.hourglass_bottom),
              ),
              value: widget.currentReservation.status.name,
              onChanged: (newValue) {statusController.text = newValue.toString();},
              items: <ReservationStatusEnum>[...ReservationStatusEnum.values].map<DropdownMenuItem<String>>((ReservationStatusEnum value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact client',
                icon: Icon(Icons.phone),
              ),
              controller: userContactController
                ..text = widget.currentReservation.user_contact != null ? widget.currentReservation.user_contact! : '',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Commentaire client',
                icon: Icon(Icons.comment),
              ),
              controller: userCommentController
                ..text = widget.currentReservation.user_comment != null ? widget.currentReservation.user_comment! : '',
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  backgroundColor: Colors.blue[900]),
              onPressed: () => handleSubmit(context),
              child: Text('Confirmer'),
            )
          ],
        ));
  }
}
