import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../api.dart';

class CreateLocationForm extends StatefulWidget {
  CreateLocationForm({Key? key}) : super(key: key);

  @override
  State<CreateLocationForm> createState() => _CreateLocationFormState();
}

class _CreateLocationFormState extends State<CreateLocationForm> {
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
  bool parking = false;
  bool kitchen = false;
  bool wifi = false;
  bool sanitary = false;
  bool heater = false;
  bool air_conditioner = false;
  bool terrace = false;
  bool barbecue = false;
  late PlatformFile file;
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
    parking = false;
    kitchen = false;
    wifi = false;
    sanitary = false;
    heater = false;
    air_conditioner = false;
    terrace = false;
    barbecue = false;
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
    };

    StreamedResponse res = await LocationApi().create(data, file);

    if (res.statusCode == 201 && mounted) Navigator.pop(context);
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
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            controller: stripeProductIdController,
            decoration: const InputDecoration(
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
            controller: descriptionController,
            decoration: const InputDecoration(
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
            controller: surfaceController,
            decoration: const InputDecoration(
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
            controller: maxPersonsController,
            decoration: const InputDecoration(
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
            controller: pricePerNightController,
            decoration: const InputDecoration(
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
            controller: bedroomsController,
            decoration: const InputDecoration(
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
            controller: slotRemainingController,
            decoration: const InputDecoration(
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
            title: const Text('Parking'),
            value: parking,
            onChanged: (bool value) {
              setState(() {
                parking = !parking;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: const Text('Cuisine'),
            value: kitchen,
            onChanged: (bool value) {
              setState(() {
                kitchen = !kitchen;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: const Text('Connexion internet'),
            value: wifi,
            onChanged: (bool value) {
              setState(() {
                wifi = !wifi;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: const Text('Sanitaires privatifs'),
            value: sanitary,
            onChanged: (bool value) {
              setState(() {
                sanitary = !sanitary;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: const Text('Chauffage'),
            value: heater,
            onChanged: (bool value) {
              setState(() {
                heater = !heater;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: const Text('Climatisation'),
            value: air_conditioner,
            onChanged: (bool value) {
              setState(() {
                air_conditioner = !air_conditioner;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: const Text('Terrasse'),
            value: terrace,
            onChanged: (bool value) {
              setState(() {
                terrace = !terrace;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          SwitchListTile(
            title: const Text('Barbecue'),
            value: barbecue,
            onChanged: (bool value) {
              setState(() {
                barbecue = !barbecue;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
            onPressed: () async {
              result = (await FilePicker.platform.pickFiles(withData: true))!;

              if (result != null) {
                setState(() {
                  file = result.files.single;
                });
              }
            },
            child: Text('Sélectionnez une image'),
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
