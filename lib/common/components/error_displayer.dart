import 'package:flutter/material.dart';

class ErrorDisplayer {
  ErrorDisplayer._();

  static buildErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: Container(
              padding: EdgeInsets.all(16),
              height: 90,
              decoration: BoxDecoration(
                  color: Color(0xFFC72C41),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Text(message),
            )
        ),
    );
  }
}
