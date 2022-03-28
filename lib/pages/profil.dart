import 'package:flutter/material.dart';


class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  static String routeName = '/profil';

  @override
  State<Profil> createState() => _Profil();
}

class _Profil extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, initialIndex: 0, child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.alternate_email_outlined),
              ),
              Tab(
                icon: Icon(Icons.alarm_on_sharp),
              ),
              Tab(
                icon: Icon(Icons.app_registration_rounded),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    )
    );
  }
}



