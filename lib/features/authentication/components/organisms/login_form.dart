import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:mobilapp/features/authentication/api.dart';

import '../../../../common/components/error_displayer.dart';
import '../../../../pages/list_user_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController googleIdController = TextEditingController();
  String? _currentUserGoogleId;

  dynamic _handleSubmit(BuildContext ctx) async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    Map<String, dynamic> data = {
      'email': emailController.text,
      'password': passwordController.text,
      'google_id': _currentUserGoogleId,
    };

    Response res = await AuthenticationApi().login(data);

    if (res.statusCode != 200 && mounted) {
      return ScaffoldMessenger.of(context).showSnackBar(
          ErrorDisplayer.buildErrorSnackbar(context, jsonDecode(utf8.decode(res.bodyBytes))['message'])
      );
    }

    if (mounted) Navigator.of(context).pushReplacementNamed(ListUserPage.routeName);
  }

  dynamic _signInWithGoogle() async {
    try {
      GoogleSignInAccount? res = await _googleSignIn.signIn();

      if (res == null) throw Error();

      Map<String, dynamic> data = {
        'google_id': res.id,
      };

      Response apiResponse = await AuthenticationApi().login(data);

      if (apiResponse.statusCode != 200 && mounted) {
        return ScaffoldMessenger.of(context).showSnackBar(
            ErrorDisplayer.buildErrorSnackbar(context, jsonDecode(utf8.decode(apiResponse.bodyBytes))['message'])
        );
      }

      if (mounted) Navigator.of(context).pushReplacementNamed(ListUserPage.routeName);

    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Adresse mail',
                icon: Icon(Icons.abc)
            ),
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Mot de passe',
              icon: Icon(Icons.password),
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Champs requis';
              }
              return null;
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
            onPressed: () => _handleSubmit(context),
            child: Text('Connexion'),
          ),
          SignInButton(
            Buttons.Google,
            text: "Sign in with Google",
            onPressed: () => _signInWithGoogle(),
          )
        ],
      ),
    );
  }
}
