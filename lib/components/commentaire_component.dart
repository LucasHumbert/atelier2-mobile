import 'package:atelier/model/commentaire.dart';
import 'package:flutter/material.dart';


class CommentaireComponent extends StatefulWidget {

  Commentaire commentaire;

  CommentaireComponent(this.commentaire , {Key? key}) : super(key: key);

  @override
  State<CommentaireComponent> createState() => _CommentaireComponent();
}

class _CommentaireComponent extends State<CommentaireComponent> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150),
        child: Container(
          child: Text(widget.commentaire.userfirstname + ' ' + widget.commentaire.userlastname + ' : ' + widget.commentaire.content),
        ),
      );
  }
}
