import 'package:atelier/model/event.dart';
import 'package:atelier/pages/one_event.dart';
import 'package:flutter/material.dart';

class EventPreview extends StatefulWidget {

   Event event;

   EventPreview(this.event, {Key? key}) : super(key: key);

  @override
  State<EventPreview> createState() => _EventPreviewState();
}

class _EventPreviewState extends State<EventPreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OneEvent.routeName, arguments: widget.event);
      },
      child: Container(
          child: Column(
            children:[
              Text(widget.event.title),
              Text(widget.event.description),
              Text(widget.event.address),
              Text(widget.event.date)
            ],
          )
      ),
    );
  }
}
