import 'package:flutter/material.dart';

import '../../models/user.dart';

class UserListCard extends StatelessWidget {
  final User currentUser;

  const UserListCard(this.currentUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, size: 40),
            title: Text('${currentUser.firstname} ${currentUser.lastname}'),
            subtitle: Text(currentUser.email),
          ),
        ],
      ),
    );
  }
}
