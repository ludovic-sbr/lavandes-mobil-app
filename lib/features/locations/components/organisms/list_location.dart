import 'package:flutter/material.dart';
import 'package:mobilapp/common/components/search_bar.dart';

import '../../../../common/components/loader.dart';
import '../../../../common/components/page_error.dart';
import '../../../../pages/create_location_page.dart';
import '../../api.dart';
import '../../models/location.dart';
import '../molecules/location_list_card.dart';

class ListLocation extends StatefulWidget {
  ListLocation({Key? key}) : super(key: key);

  @override
  State<ListLocation> createState() => _ListLocationState();
}

class _ListLocationState extends State<ListLocation> {
  late Future<List<Location>> dataFuture;
  late TextEditingController searchParams = TextEditingController();

  @override
  void initState() {
    super.initState();

    dataFuture = LocationApi().getAll();
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
      dataFuture = LocationApi().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(6.0),
        child: Column(children: <Widget>[
          SizedBox(
            child: FutureBuilder<List<Location>>(
              future: dataFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Location>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SearchBar(searchParams, updateSearchParams),
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
                        if (snapshot.data![index].name.toLowerCase().startsWith(
                            searchParams.value.text.toLowerCase())) {
                          return LocationListCard(
                              snapshot.data![index], refreshData);
                        } else {
                          return Container();
                        }
                      },
                    )
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    PageError(snapshot.error as String),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateLocationPage()))
            .then((_) => refreshData()),
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
