import 'package:flutter/material.dart';

import '../../api.dart';
import '../../models/location.dart';
import '../molecules/location_list_card.dart';

class ListLocation extends StatefulWidget {
  const ListLocation({Key? key}) : super(key: key);

  @override
  State<ListLocation> createState() => _ListLocationState();
}

class _ListLocationState extends State<ListLocation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Location>>(
      future: LocationApi().getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Location>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (ctx, index) {
                return LocationListCard(snapshot.data![index]);
              },
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Text('Erreur: ${snapshot.error}'),
          ];
        } else {
          children = const <Widget>[
            Text('Chargement...'),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
