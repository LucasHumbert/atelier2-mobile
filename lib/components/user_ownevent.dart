import 'package:atelier/components/event_preview.dart';
import 'package:atelier/model/event.dart';
import 'package:atelier/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:atelier/data/dart_var.dart' as data;
import 'package:shared_preferences/shared_preferences.dart';

class UserOwnEvent extends StatefulWidget {

  UserOwnEvent( {Key? key}) : super(key: key);

  @override
  State<UserOwnEvent> createState() => _UserOwnEvent();
}

class _UserOwnEvent extends State<UserOwnEvent> {

  Future<List<Event>> getUserEventJoin() async {
    final prefs = await SharedPreferences.getInstance();

    List<Event> events = [];

    String? id = prefs.getString('idUser');
    String? token = prefs.getString('accessToken');

    String bearerAuth = 'Bearer ' + token!;

    Dio dio = new Dio();
    Response r = await dio.get(data.apievent + '?creator_id=' + id!, options: Options(
        headers: <String, String>{
          'authorization': bearerAuth
        }
    ));

    if(r.statusCode == 200) {
      for(var event in r.data['events']){
        Event nevent = Event.fromJson(event);
        events.insert(0, nevent);
      }
    }

    return events;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: FutureBuilder(
              future: getUserEventJoin(),
              builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
                if(snapshot.hasData) {
                  return ListView.separated(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return EventPreview(snapshot.data![index]);
                      },
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider()
                  );
                } else {
                  return Text('Fetching');
                }
              }),

        )
      ],
    );
  }
}
