import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPreview extends StatefulWidget {
  const EventPreview({Key? key}) : super(key: key);

  static String routeName = '/';

  @override
  State<EventPreview> createState() => _EventPreviewState();
}

class _EventPreviewState extends State<EventPreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('test');
      },
      child: Container(
          child: Column(
            children: const [
              Text("Titre de l'event"),
            ],
          )
      ),
    );
  }
}
