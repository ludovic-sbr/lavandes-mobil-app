import 'package:flutter/material.dart';
import 'package:mobilapp/features/users/components/organisms/list_user.dart';

class ListUserPage extends StatelessWidget {
  static const int routeId = 0;
  static const String routeName = '/user';

  ListUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Column(children: <Widget>[
            SizedBox(
              child: ListUser(),
            ),
          ]),
        ),
      ),
    );
  }
}
