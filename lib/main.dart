import 'package:atelier/pages/create_event.dart';
import 'package:atelier/pages/event.dart';
import 'package:atelier/pages/home.dart';
import 'package:atelier/pages/profil.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: MyHomePage.routeName,
      routes: {
        MyHomePage.routeName : (context) => const MyHomePage(),
        EventPage.routeName: (context) => const EventPage(),
        CreateEventPage.routeName: (context) => const CreateEventPage(),
        Profil.routeName: (context) => const Profil(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}


