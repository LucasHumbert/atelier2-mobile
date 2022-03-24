import 'package:atelier/components/event_preview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);
  

  static String routeName = '/event';

  @override
  State<EventPage> createState() => _EventPage();
}

class _EventPage extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
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
                      onPressed: () => {
                        Navigator.pushNamed(context, '/create_event')
                      }, child: const Text('CREER UN EVENEMENT')
                  ),
                  ElevatedButton(onPressed: () => {}, child: Text('MON PROFIL')),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return EventPreview();
                    },
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) { return const Divider(); },
                  )
                ],
              ),
            )
        )
    );
  }
}
