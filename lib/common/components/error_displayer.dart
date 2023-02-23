import 'package:flutter/material.dart';

class ErrorDisplayer {
  ErrorDisplayer._();

  static buildErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red[900],
            content: Text(message),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            )
        ),
    );
  }
}
