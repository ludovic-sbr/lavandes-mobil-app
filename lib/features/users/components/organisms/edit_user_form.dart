import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:mobilapp/common/models/role.dart';
import 'package:mobilapp/features/users/api.dart';
import 'package:mobilapp/features/users/models/user.dart';

import '../../../../common/components/error_displayer.dart';

class EditUserForm extends StatefulWidget {
  final User currentUser;

  EditUserForm(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstnameController = TextEditingController(text: widget.currentUser.firstname);
  late TextEditingController lastnameController = TextEditingController(text: widget.currentUser.lastname);
  late TextEditingController emailController = TextEditingController(text: widget.currentUser.email);
  late TextEditingController roleNameController = TextEditingController(text: widget.currentUser.role.name);

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    roleNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  dynamic handleSubmit(BuildContext ctx) async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    Map<String, dynamic> data = {
      'firstname': firstnameController.text,
      'lastname': lastnameController.text,
      'email': emailController.text,
      'roleName': roleNameController.text,
    };

    Response res = await UserApi().edit(widget.currentUser.id, data);

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
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Prénom',
                  icon: Icon(Icons.perm_identity)
              ),
              controller: firstnameController
                ..text = widget.currentUser.firstname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nom',
                  icon: Icon(Icons.perm_identity)
              ),
              controller: lastnameController
                ..text = widget.currentUser.lastname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Adresse mail',
                  icon: Icon(Icons.abc)
              ),
              controller: emailController
                ..text = widget.currentUser.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Champs requis';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Role',
                icon: Icon(Icons.policy),
              ),
              value: widget.currentUser.role.name,
              onChanged: (newValue) {roleNameController.text = newValue.toString();},
              items: <RoleEnum>[...RoleEnum.values].map<DropdownMenuItem<String>>((RoleEnum value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),
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
