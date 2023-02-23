import 'package:flutter/material.dart';
import 'package:mobilapp/common/components/search_bar.dart';

import '../../../../common/components/loader.dart';
import '../../../../common/components/page_error.dart';
import '../../../../pages/create_reservation_page.dart';
import '../../api.dart';
import '../../models/reservation.dart';
import '../molecules/reservation_list_card.dart';

class ListReservation extends StatefulWidget {
  ListReservation({Key? key}) : super(key: key);

  @override
  State<ListReservation> createState() => _ListReservationState();
}

class _ListReservationState extends State<ListReservation> {
  late Future<List<Reservation>> dataFuture;
  late TextEditingController searchParams = TextEditingController();

  @override
  void initState() {
    super.initState();

    dataFuture = ReservationApi().getAll();
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
      dataFuture = ReservationApi().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(6.0),
        child: Column(children: <Widget>[
          SizedBox(
            child: FutureBuilder<List<Reservation>>(
              future: dataFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Reservation>> snapshot) {
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
                          SearchBar(searchParams, updateSearchParams, 'Recherchez une clé...'),
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
                          if (snapshot.data![index].reservation_key
                              .toLowerCase()
                              .contains(
                              searchParams.value.text.toLowerCase())) {
                            return ReservationListCard(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateReservationPage()))
            .then((_) => refreshData()),
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
