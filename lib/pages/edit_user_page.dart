import 'package:flutter/material.dart';

import '../features/users/components/organisms/edit_user_form.dart';
import '../features/users/models/user.dart';

class EditUserPage extends StatelessWidget {
  final User currentUser;

  EditUserPage(this.currentUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier ${currentUser.firstname} ${currentUser.lastname}'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: EditUserForm(currentUser),
      )),
    );
  }
}
