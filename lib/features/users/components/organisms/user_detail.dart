import 'package:flutter/material.dart';

import '../../../../common/models/role.dart';
import '../../models/user.dart';

class UserDetail extends StatelessWidget {
  final User currentUser;

  UserDetail(this.currentUser, {super.key});

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
          subtitle: Text(currentUser.id.toString()),
        ),
        ListTile(
          leading: Icon(Icons.perm_identity),
          title: Text('Nom complet'),
          subtitle: Text('${currentUser.firstname} ${currentUser.lastname}'),
        ),
        ListTile(
          leading: Icon(Icons.abc),
          title: Text('Adresse email'),
          subtitle: Text(currentUser.email),
        ),
        ListTile(
          leading: Icon(Icons.account_balance),
          title: Text('Google ID'),
          subtitle: Text(currentUser.google_id != null ? currentUser.google_id! : 'Compte manuel'),
        ),
        ListTile(
          leading: Icon(Icons.policy),
          title: Text('Role'),
          subtitle: Text(currentUser.role.name == RoleEnum.ADMIN.name ? 'Administrateur' : currentUser.role.name == RoleEnum.DEVELOPER.name ? 'Développeur' : 'Vacancier'),
        ),
      ],
    ));
  }
}
