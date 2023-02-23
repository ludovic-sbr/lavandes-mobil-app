import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../common/components/error_displayer.dart';
import '../../../../pages/edit_user_page.dart';
import '../../../../pages/user_page.dart';
import '../../api.dart';
import '../../models/user.dart';

class UserListCard extends StatelessWidget {
  final User currentUser;
  final Function refreshData;

  UserListCard(this.currentUser, this.refreshData,
      {super.key});

  dynamic handleDelete(BuildContext context, [bool mounted = true]) async {
    Response res = await UserApi().deleteById(currentUser.id);

    if (res.statusCode != 200 && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          ErrorDisplayer.buildErrorSnackbar(context, jsonDecode(utf8.decode(res.bodyBytes))['message'])
      );
    }

    if (mounted) {
      refreshData();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
                '${currentUser.firstname} ${currentUser.lastname}'),
            subtitle: Text(currentUser.email),
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
                                                  UserPage(
                                                      currentUser))),
                                    }),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (ctx) =>
                                            EditUserPage(
                                                currentUser)))
                                        .then((_) => refreshData()),
                                  },
                                  child: Icon(Icons.edit,
                                      color: Colors.blueGrey),
                                ),
                                TextButton(
                                  child: Icon(Icons.delete_forever,
                                      color: Colors.red),
                                  onPressed: () => {
                                    handleDelete(context),
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
