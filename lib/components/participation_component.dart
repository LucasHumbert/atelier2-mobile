import 'package:atelier/model/user.dart';
import 'package:flutter/material.dart';

class ParticipationComponent extends StatefulWidget {

  User user;

  ParticipationComponent(this.user , {Key? key}) : super(key: key);

  @override
  State<ParticipationComponent> createState() => _ParticipationComponent();
}

class _ParticipationComponent extends State<ParticipationComponent> {

  @override
  Widget build(BuildContext context) {

    comeToEvent() {
        if(widget.user.choice == 1) {
          return 'Participe';
        } else if (widget.user.choice == 2) {
          return 'Doit se prononcer';
        } else {
          return 'Ne participe pas';
        }
    }

    String participe = comeToEvent();

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 150),
      child: Container(
        child: Text(widget.user.firstname + ' ' + widget.user.lastname + ' : ' + participe),
      ),
    );
  }
}
