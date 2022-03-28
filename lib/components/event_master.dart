import 'package:atelier/components/event_full.dart';
import 'package:atelier/model/event.dart';
import 'package:flutter/material.dart';

import 'event_preview.dart';

class EventMaster extends StatefulWidget {

  List<Event>? event;

  EventMaster(this.event , {Key? key}) : super(key: key);

  @override
  State<EventMaster> createState() => _EventMaster();
}

class _EventMaster extends State<EventMaster> {

  int cardid = -1;

  void showDetails(int index){
    setState(() {
      if(index == cardid) {
        cardid = -1;
      } else {
        cardid = index;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 525,
      width: 800,
      child: ListView.separated(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return index == cardid ? EventFull(widget.event![index]) : EventPreview(widget.event![index], showDetails , index);
          },
          itemCount: widget.event!.length,
          separatorBuilder: (BuildContext context, int index) => const Divider()
      ),
    );
  }
}
