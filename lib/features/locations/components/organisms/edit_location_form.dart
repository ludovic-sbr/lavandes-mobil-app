import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../api.dart';
import '../../models/location.dart';

class EditLocationForm extends StatefulWidget {
  final Location currentLocation;

  EditLocationForm(this.currentLocation, {Key? key}) : super(key: key);

  @override
  State<EditLocationForm> createState() => _EditLocationFormState();
}

class _EditLocationFormState extends State<EditLocationForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController stripeProductIdController =
      TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController surfaceController = TextEditingController();
  late TextEditingController maxPersonsController = TextEditingController();
  late TextEditingController pricePerNightController = TextEditingController();
  late TextEditingController bedroomsController = TextEditingController();
  late TextEditingController slotRemainingController = TextEditingController();
  late bool parking;
  late bool kitchen;
  late bool wifi;
  late bool sanitary;
  late bool heater;
  late bool air_conditioner;
  late bool terrace;
  late bool barbecue;
  late PlatformFile? file;
  late FilePickerResult result;

  @override
  void dispose() {
    nameController.dispose();
    stripeProductIdController.dispose();
    descriptionController.dispose();
    surfaceController.dispose();
    maxPersonsController.dispose();
    pricePerNightController.dispose();
    bedroomsController.dispose();
    slotRemainingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    parking = widget.currentLocation.parking;
    kitchen = widget.currentLocation.kitchen;
    wifi = widget.currentLocation.wifi;
    sanitary = widget.currentLocation.sanitary;
    heater = widget.currentLocation.heater;
    air_conditioner = widget.currentLocation.air_conditioner;
    terrace = widget.currentLocation.terrace;
    barbecue = widget.currentLocation.barbecue;
    file = null;
  }

  void handleSubmit(BuildContext ctx) async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    Map<String, dynamic> data = {
      'name': nameController.text,
      'stripeProductId': stripeProductIdController.text,
      'description': descriptionController.text,
      'surface': surfaceController.text,
      'max_persons': maxPersonsController.text,
      'price_per_night': pricePerNightController.text,
      'bedrooms': bedroomsController.text,
      'slot_remaining': slotRemainingController.text,
      'parking': parking.toString(),
      'kitchen': kitchen.toString(),
      'wifi': wifi.toString(),
      'sanitary': sanitary.toString(),
      'heater': heater.toString(),
      'air_conditioner': air_conditioner.toString(),
      'terrace': terrace.toString(),
      'barbecue': barbecue.toString(),
      'image': file
    };

    StreamedResponse res = await LocationApi().edit(widget.currentLocation.id, data);

    if (res.statusCode == 200 && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nom *',
            ),
            controller: nameController..text = widget.currentLocation.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
              onPressed: () async {
                result = (await FilePicker.platform.pickFiles(withData: true))!;

                if (result != null) {
                  setState(() {
                    file = result.files.single;
                  });
                }
              },
              child: Text('Sélectionner une image'),
            ),
          ),
          Text(file != null ? 'Fichier : ${file!.name}' : 'Fichier : ${widget.currentLocation.image.name}'),
          TextFormField(
            controller: stripeProductIdController..text = widget.currentLocation.stripeProductId,
            decoration: InputDecoration(
              labelText: 'Id Stripe du produit *',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            controller: descriptionController..text = widget.currentLocation.description,
            decoration: InputDecoration(
              labelText: 'Description *',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            controller: surfaceController..text = widget.currentLocation.surface.toString(),
            decoration: InputDecoration(
              labelText: 'Surface *',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            controller: maxPersonsController..text = widget.currentLocation.max_persons.toString(),
            decoration: InputDecoration(
              labelText: 'Nombre de personnes *',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            controller: pricePerNightController..text = widget.currentLocation.price_per_night.toString(),
            decoration: InputDecoration(
              labelText: 'Prix par nuit *',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            controller: bedroomsController..text = widget.currentLocation.bedrooms.toString(),
            decoration: InputDecoration(
              labelText: 'Nombre de chambres *',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            controller: slotRemainingController..text = widget.currentLocation.slot_remaining.toString(),
            decoration: InputDecoration(
              labelText: 'Total d\'emplacements disponibles *',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          SwitchListTile(
            title: Text('Parking'),
            value: parking,
            onChanged: (bool value) {
              setState(() {
                parking = !parking;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: Text('Cuisine'),
            value: kitchen,
            onChanged: (bool value) {
              setState(() {
                kitchen = !kitchen;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: Text('Connexion internet'),
            value: wifi,
            onChanged: (bool value) {
              setState(() {
                wifi = !wifi;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: Text('Sanitaires privatifs'),
            value: sanitary,
            onChanged: (bool value) {
              setState(() {
                sanitary = !sanitary;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: Text('Chauffage'),
            value: heater,
            onChanged: (bool value) {
              setState(() {
                heater = !heater;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: Text('Climatisation'),
            value: air_conditioner,
            onChanged: (bool value) {
              setState(() {
                air_conditioner = !air_conditioner;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: Text('Terrasse'),
            value: terrace,
            onChanged: (bool value) {
              setState(() {
                terrace = !terrace;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: Text('Barbecue'),
            value: barbecue,
            onChanged: (bool value) {
              setState(() {
                barbecue = !barbecue;
              });
            },
            secondary: Icon(Icons.lightbulb_outline),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20), backgroundColor: Colors.blue[900]),
            onPressed: () => handleSubmit(context),
            child: Text('Confirmer'),
          )
        ],
      )
    );
  }
}
