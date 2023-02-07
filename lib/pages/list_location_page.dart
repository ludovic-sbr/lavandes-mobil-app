import 'package:flutter/material.dart';
import 'package:mobilapp/features/locations/components/organisms/list_location.dart';

class ListLocationPage extends StatelessWidget {
  ListLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            child: ListLocation(),
          ),
        ]),
      ),
    );
  }
}
