import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator()
      ),
    );
  }
}
