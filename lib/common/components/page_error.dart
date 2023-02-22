import 'package:flutter/material.dart';

class PageError extends StatelessWidget {
  final String message;

  const PageError(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
          alignment: Alignment.center, child: Text(message)
      ),
    );
  }
}
