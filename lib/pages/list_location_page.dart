import 'package:flutter/material.dart';
import 'package:mobilapp/features/locations/components/organisms/list_location.dart';

class ListLocationPage extends StatelessWidget {
  static const int routeId = 2;
  static const String routeName = '/location';

  ListLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListLocation();
  }
}
