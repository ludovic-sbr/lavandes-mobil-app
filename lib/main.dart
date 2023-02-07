import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilapp/pages/list_location_page.dart';
import 'package:mobilapp/pages/list_user_page.dart';

import 'common/components/layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camping des Lavandes',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.amber),
          textTheme: TextTheme(
              headline6: GoogleFonts.economica(fontWeight: FontWeight.bold))),
      initialRoute: '/reservation',
      routes: {
        '/user': (context) => ListUserPage(),
        '/reservation': (context) => Layout(),
        '/location': (context) => ListLocationPage()
      },
    );
  }
}
