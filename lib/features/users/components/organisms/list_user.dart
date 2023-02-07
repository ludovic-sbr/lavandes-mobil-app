import 'package:flutter/material.dart';
import 'package:mobilapp/features/users/components/molecules/user_list_card.dart';

import '../../api.dart';
import '../../models/user.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: UserApi().getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (ctx, index) {
                return UserListCard(snapshot.data![index]);
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
