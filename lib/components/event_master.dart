import 'package:atelier/model/event.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'event_preview.dart';

class EventMaster extends StatefulWidget {

  List<Event>? event;

  EventMaster(this.event , {Key? key}) : super(key: key);

  @override
  State<EventMaster> createState() => _EventMaster();
}

class _EventMaster extends State<EventMaster> {
  @override
  Widget build(BuildContext context) {
    return           Container(
      height: 525,
      width: 800,
      child: ListView.separated(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return EventPreview();
          },
          itemCount: 150,
          separatorBuilder: (BuildContext context, int index) => const Divider()
      ),
    );
  }
}
