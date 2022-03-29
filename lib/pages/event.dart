import 'package:atelier/components/event_master.dart';
import 'package:atelier/data/event_list.dart';
import 'package:atelier/model/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  static String routeName = '/event';

  @override
  State<EventPage> createState() => _EventPage();
}

class _EventPage extends State<EventPage> {

  @override
  void initState() {
    super.initState();
  }

  void _loadAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventCollection>(
        builder: (context, event, child) => SafeArea(
                child: Scaffold(
                    body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                        text: const TextSpan(
                            text: 'EVENEMENT PUBLIQUE :',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0))),
                  )),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/create_event')},
                      child: const Text('CREER UN EVENEMENT')),
                  ElevatedButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/profil')},
                      child: Text('MON PROFIL')),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<Event>>(
                      future: event.getAllTask(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Event>> snapshot) {
                        if (snapshot.hasData) {
                          return EventMaster(snapshot.data);
                        } else {
                          return Container(
                            child: Text('Je suis un container'),
                          );
                        }
                      }),
                ],
              ),
            ))));
  }
}
