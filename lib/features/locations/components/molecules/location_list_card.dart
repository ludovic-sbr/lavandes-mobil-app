import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobilapp/pages/edit_location_page.dart';

import '../../../../pages/location_page.dart';
import '../../api.dart';
import '../../models/location.dart';

class LocationListCard extends StatelessWidget {
  final Location currentLocation;
  final Function refreshData;

  const LocationListCard(this.currentLocation, this.refreshData, {super.key});

  void handleDelete(BuildContext context, [bool mounted = true]) async {
    Response res = await LocationApi().deleteById(currentLocation.id);

    if (res.statusCode == 200 && mounted) {
      refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(currentLocation.image.publicUrl)),
            title: Text(
                '${currentLocation.name} - ${currentLocation.max_persons} places'),
            subtitle: Text(currentLocation.stripeProductId),
            trailing: TextButton(
                child: Icon(Icons.add, color: Colors.grey),
                onPressed: () => {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton(
                                        child: Icon(Icons.remove_red_eye,
                                            color: Colors.grey),
                                        onPressed: () => {
                                              Navigator.pop(context),
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          LocationPage(
                                                              currentLocation))),
                                            }),
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) =>
                                                    EditLocationPage(
                                                        currentLocation)))
                                            .then((_) => refreshData()),
                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.blueGrey),
                                    ),
                                    TextButton(
                                      child: Icon(Icons.delete_forever,
                                          color: Colors.red),
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        handleDelete(context)
                                      },
                                    ),
                                  ],
                                ));
                          })
                    }),
          ),
        ],
      ),
    );
  }
}
