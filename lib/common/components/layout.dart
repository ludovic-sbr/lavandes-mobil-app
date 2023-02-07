import 'package:flutter/material.dart';
import 'package:mobilapp/pages/list_reservation_page.dart';

import '../../pages/list_location_page.dart';
import '../../pages/list_user_page.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<Map<String, dynamic>> _pages = [
    {
      'page': ListUserPage(),
      'title': 'Utilisateurs',
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

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person),
            label: "Utilisateurs",
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
