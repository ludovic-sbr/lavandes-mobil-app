import 'package:flutter/material.dart';
import 'package:mobilapp/features/authentication/components/organisms/login_form.dart';

class LoginPage extends StatelessWidget {
  static const int routeId = 0;
  static const String routeName = '/login';

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: LoginForm(),
      )),
    );
  }
}
