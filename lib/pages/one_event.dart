import 'package:atelier/components/commentaire_component.dart';
import 'package:atelier/components/participation_component.dart';
import 'package:atelier/model/event.dart';
import 'package:atelier/model/user.dart';
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
  late TextEditingController _message = TextEditingController();

  /**
  Fetching event info
   */

  Future<List<Commentaire>> getComments(args) async {
    Dio dio = Dio();
    Response r =
        await dio.get(data.apievent + "/" + args.id + '?embed[]=messages');
    List<Commentaire> comments = [];

    if (r.statusCode == 200) {
      for (var c in r.data['messages']) {
        Commentaire x = Commentaire(
            userId: c['user_id'],
            content: c['content']!,
            date: c['date'],
            userfirstname: c['user_firstname'],
            userlastname: c['user_lastname']);
        comments.insert(0, x);
      }
    }

    return comments;
  }


  /**
   * Fetching users in event
   */
  Future<List<User>> getUser(args) async {
    Dio dio = Dio();
    Response r =
    await dio.get(data.apievent + "/" + args.id + '?embed[]=messages&embed[]=users');
    List<User> users = [];

    if (r.statusCode == 200) {
      for (var u in r.data['users']) {
        User user = User(userId: u['user_id'], firstname: u['firstname'], lastname: u['lastname'], choice: u['choice']);
        users.insert(0, user);
      }
    }

    return users;
  }




  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Event;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
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
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                      builder: (ctx) => Container(
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
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String? token = prefs.getString('accessToken');
                    String bearerAuth = 'Bearer ' + token!;

                    Dio dio = Dio();
                    await dio.post(
                        data.apievent + '/' + args.id + '/users/',
                        options: Options(headers: <String, String>{
                          'authorization': bearerAuth
                        }),
                        data: {'choice': 1});
                  },
                  child: Text('Je participe')),
              ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String? token = prefs.getString('accessToken');
                    String bearerAuth = 'Bearer ' + token!;

                    Dio dio = Dio();
                    await dio.post(
                        data.apievent + '/' + args.id + '/users/',
                        options: Options(headers: <String, String>{
                          'authorization': bearerAuth
                        }),
                        data: {'choice': 0});
                  },
                  child: Text('Je ne participe pas'))
            ],
          ),
          const Divider(),
          FutureBuilder(
              future: getUser(args),
              builder: (context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ParticipationComponent(snapshot.data![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                      itemCount: snapshot.data!.length);
                } else {
                  return Text('No data found');
                }
              }),
          const SizedBox(
            height: 100.0,
          ),
          Text('Commentaire :'),
          FutureBuilder(
              future: getComments(args),
              builder: (context, AsyncSnapshot<List<Commentaire>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CommentaireComponent(snapshot.data![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: snapshot.data!.length);
                } else {
                  return Text('No data found');
                }
              }),
          Form(
              child: TextFormField(
            controller: _message,
          )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString('accessToken');
                String bearerAuth = 'Bearer ' + token!;


                Dio dio = new Dio();
                await dio.post(data.apievent + '/' + args.id + '/message', data: {
                  'content' : _message.text,
                }, options: Options(
                  headers: <String, String>{
                  'authorization': bearerAuth
                }
                ));
              },
              child: Text('Envoyer le message'))
        ],
      ),
    )));
  }
}
