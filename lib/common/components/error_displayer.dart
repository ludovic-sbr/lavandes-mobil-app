import 'package:flutter/material.dart';

class ErrorDisplayer extends StatelessWidget {
  final String? errorMessage;

  ErrorDisplayer(this.errorMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
          alignment: Alignment.center,
          child: Text(
              errorMessage != null ?
              errorMessage! :
              'Une erreur est survenue lors du chargement de vos données.')
      ),
    );
  }
}
