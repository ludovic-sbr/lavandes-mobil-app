import 'package:flutter/material.dart';
import 'package:mobilapp/common/components/search_bar.dart';

import '../../../../common/components/loader.dart';
import '../../../../common/components/page_error.dart';
import '../../api.dart';
import '../../models/user.dart';
import '../molecules/user_list_card.dart';

class ListUser extends StatefulWidget {
  ListUser({Key? key}) : super(key: key);

  @override
  State<ListUser> createState() => _ListReservationState();
}

class _ListReservationState extends State<ListUser> {
  late Future<List<User>> dataFuture;
  late TextEditingController searchParams = TextEditingController();

  @override
  void initState() {
    super.initState();

    dataFuture = UserApi().getAll();
    searchParams.text = '';
  }

  @override
  void dispose() {
    searchParams.dispose();
    super.dispose();
  }

  void updateSearchParams(String newSearchParams) {
    setState(() {
      searchParams.text = newSearchParams;
      searchParams.selection = TextSelection.fromPosition(
          TextPosition(offset: searchParams.text.length));
    });
  }

  void refreshData() {
    setState(() {
      searchParams.text = '';
      dataFuture = UserApi().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(6.0),
        child: Column(children: <Widget>[
          SizedBox(
            child: FutureBuilder<List<User>>(
              future: dataFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<User>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    children = <Widget>[
                      PageError('Aucune donnée à afficher.')
                    ];
                  } else {
                    children = <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SearchBar(searchParams, updateSearchParams, 'Recherchez un email...'),
                        ],
                      ),
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 4);
                        },
                        itemBuilder: (ctx, index) {
                          if (snapshot.data![index].email
                              .toLowerCase()
                              .contains(
                              searchParams.value.text.toLowerCase())) {
                            return UserListCard(
                                snapshot.data![index], refreshData);
                          } else {
                            return Container();
                          }
                        },
                      )
                    ];
                  }
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    PageError(snapshot.error as String)
                  ];
                } else {
                  children = <Widget>[
                    Loader(),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
