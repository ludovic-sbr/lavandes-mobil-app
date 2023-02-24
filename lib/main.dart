import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilapp/features/authentication/service.dart';
import 'package:mobilapp/pages/list_location_page.dart';
import 'package:mobilapp/pages/list_reservation_page.dart';
import 'package:mobilapp/pages/list_user_page.dart';
import 'package:mobilapp/pages/login_page.dart';

import 'common/components/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isLogged = await AuthService().isLogged();
  final MyApp myApp = MyApp(
    initialRoute: isLogged ? ListUserPage.routeName : LoginPage.routeName,
  );
  runApp(myApp);
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camping des Lavandes',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
          textTheme: TextTheme(
              headline6: GoogleFonts.economica(fontWeight: FontWeight.bold))),
      initialRoute: initialRoute,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        ListUserPage.routeName: (context) => Layout(ListUserPage.routeId),
        ListReservationPage.routeName: (context) =>
            Layout(ListReservationPage.routeId),
        ListLocationPage.routeName: (context) =>
            Layout(ListLocationPage.routeId)
      },
    );
  }
}
