import 'package:flutter/material.dart';

import '../features/users/components/organisms/user_detail.dart';
import '../features/users/models/user.dart';

class UserPage extends StatelessWidget {
  final User currentUser;

  UserPage(this.currentUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Vacancier - ${currentUser.firstname} ${currentUser.lastname}'),
      ),
      body: UserDetail(currentUser),
    );
  }
}
