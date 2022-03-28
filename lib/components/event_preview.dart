import 'package:atelier/model/event.dart';
import 'package:flutter/material.dart';

class EventPreview extends StatefulWidget {

  Function changeView;

  int index;

   Event event;

   EventPreview(this.event, this.changeView, this.index, {Key? key}) : super(key: key);

  @override
  State<EventPreview> createState() => _EventPreviewState();
}

class _EventPreviewState extends State<EventPreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.changeView(widget.index);
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
