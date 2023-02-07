import 'package:flutter/material.dart';
import 'package:mobilapp/features/users/components/organisms/list_user.dart';

class ListUserPage extends StatelessWidget {
  ListUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            child: ListUser(),
          ),
        ]),
      ),
    );
  }
}
