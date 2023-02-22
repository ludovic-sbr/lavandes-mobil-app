import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobilapp/common/components/error_displayer.dart';

import '../../../locations/api.dart';
import '../../../locations/models/location.dart';
import '../../../users/api.dart';
import '../../../users/models/user.dart';
import '../../api.dart';

class CreateReservationForm extends StatefulWidget {
  CreateReservationForm({Key? key}) : super(key: key);

  @override
  State<CreateReservationForm> createState() => _CreateReservationFormState();
}

class _CreateReservationFormState extends State<CreateReservationForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController userController = TextEditingController();
  late TextEditingController locationController = TextEditingController();
  late TextEditingController adultNbrController = TextEditingController();
  late TextEditingController childNbrController = TextEditingController();
  late TextEditingController animalNbrController = TextEditingController();
  late TextEditingController vehicleNbrController = TextEditingController();
  late TextEditingController statusController = TextEditingController();
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
      'user_comment': userCommentController.text != '' ? userCommentController.text : null,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
    };

    Response res = await ReservationApi().create(data);

    if (res.statusCode != 201 && mounted) {
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
            controller: adultNbrController,
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
            controller: childNbrController,
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
            controller: animalNbrController,
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
            controller: vehicleNbrController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: from,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101));
              if (picked != null && picked != from) {
                setState(() {
                  from = picked;
                });
              }
            },
            child: Text(from.toString()),
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: to,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101));
              if (picked != null && picked != to) {
                setState(() {
                  to = picked;
                });
              }
            },
            child: Text(to.toString()),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Contact client',
              icon: Icon(Icons.phone),
            ),
            controller: userContactController,
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
            controller: userCommentController,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
            onPressed: () => handleSubmit(context),
            child: Text('Créer la location'),
          )
        ],
      ),
    );
  }
}
