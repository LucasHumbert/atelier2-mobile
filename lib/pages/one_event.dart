import 'dart:convert';

import 'package:atelier/model/event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atelier/data/dart_var.dart' as data;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../model/commentaire.dart';

class OneEvent extends StatefulWidget {

  static String routeName = '/oneevent';

  OneEvent({Key? key}) : super(key: key);

  @override
  State<OneEvent> createState() => _OneEvent();
}

class _OneEvent extends State<OneEvent> {

  Future<List<Commentaire>> getComments(args) async {
    Dio dio = Dio();
    Response r = await dio.get(data.apievent +"/"+ args.id +'?embed[]=messages');
    List<Commentaire> comments=[];

    if(r.statusCode == 200){
      for(var c in r.data['messages']){
        Commentaire x=Commentaire(userId: c['user_id'], content: c['content']!, date: c['date']);
        comments.insert(0, x);
      }
    }
    //final body = json.decode(r.data['messages'][0]);

    return comments;
    //return body.map<Commentaire>(Commentaire.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Event;

    return SafeArea(child: Scaffold(
      body: Column (children: [
        Container(
          width: 400,
          height: 400,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(args.lat, args.lon),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return Text("© OpenStreetMap contributors");
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(args.lat, args.lon),
                    builder: (ctx) =>
                        Container(
                          child: const Icon(Icons.location_on),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(args.title),
        Text(args.description),
        Text(args.date),
        Text(args.address),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ElevatedButton(onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('accessToken');
              String bearerAuth = 'Bearer ' + token!;

              Dio dio = Dio();
              Response response = await dio.post(data.apievent + '/' + args.id + '/users/', options: Options(
                  headers: <String, String>{'authorization': bearerAuth}
              ), data: {
                'choice': 1
              });
            }, child: Text('Je participe')),
            ElevatedButton(onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('accessToken');
              String bearerAuth = 'Bearer ' + token!;

              Dio dio = Dio();
              Response response = await dio.post(data.apievent + '/' + args.id + '/users/',options: Options(
                  headers: <String, String>{'authorization': bearerAuth}
              ), data: {
                'choice': 0
              });
            }, child: Text('Je ne participe pas'))
          ],
        ),
        FutureBuilder(
          future: getComments(args),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Text("J'ai des commentaires");
            } else {
              return Text('Quand je clique ça marche pas !');
            }
          }
        )
      ],
      )
    ));
  }
}
