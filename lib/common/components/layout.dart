import 'package:flutter/material.dart';
import 'package:mobilapp/features/authentication/service.dart';
import 'package:mobilapp/pages/list_reservation_page.dart';
import 'package:mobilapp/pages/login_page.dart';

import '../../pages/list_location_page.dart';
import '../../pages/list_user_page.dart';

class Layout extends StatefulWidget {
  final int? pageId;

  Layout(this.pageId, {Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<Map<String, dynamic>> _pages = [
    {
      'page': ListUserPage(),
      'title': 'Vacanciers',
    },
    {
      'page': ListReservationPage(),
      'title': 'Réservations',
    },
    {
      'page': ListLocationPage(),
      'title': 'Locations',
    },
  ];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.pageId != null) {
      setState(() {
        _selectedPageIndex = widget.pageId!;
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void logout() {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    AuthService().logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () => logout(),
          ),
        ]
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person),
            label: "Vacanciers",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.menu_book),
            label: "Réservations",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            label: "Locations",
          ),
        ],
      ),
    );
  }
}
