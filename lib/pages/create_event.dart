import 'dart:convert';

import 'package:atelier/data/event_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atelier/data/dart_var.dart' as data;

import '../model/event.dart';

enum EventType { public, private }


class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  static String routeName = '/create_event';

  @override
  State<CreateEventPage> createState() => _CreateEventPage();
}

class _CreateEventPage extends State<CreateEventPage> {

  EventType? _choice = EventType.private;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _numstreet = TextEditingController();
  final TextEditingController _namestreet = TextEditingController();
  final TextEditingController _namecity = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child:Center(
                        child: RichText(
                            text: const TextSpan(
                                text: "Création d'évènement",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0))),
                      )
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Titre de l'évènement",
                              ),
                              controller: _title,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Description"
                              ),
                              controller: _desc,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "N°"
                              ),
                              controller: _numstreet,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Rue/Avenue"
                              ),
                              controller: _namestreet,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Ville"
                              ),
                              controller: _namecity,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            RichText(
                                text: const TextSpan(
                                    text: "DISPONIBILITE DE L'EVENEMENT",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.0,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 10.0,
                                            color: Color.fromARGB(80, 0, 0, 0),
                                          )
                                        ]))),
                            Column(
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Privé'),
                                  leading: Radio<EventType>(
                                    value: EventType.private,
                                    groupValue: _choice,
                                    onChanged: (EventType? value) {
                                      setState(() {
                                        _choice = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Public'),
                                  leading: Radio<EventType>(
                                    value: EventType.public,
                                    groupValue: _choice,
                                    onChanged: (EventType? value) {
                                      setState(() {
                                        _choice = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Center(
                              child:  Text(DateFormat('yyyy-mm-dd').format(selectedDate)),
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                {
                                  _selectDate(context)
                                },
                                child: const Text("SELECTIONNER LA DATE")),
                            Center(
                              child: Text(selectedTime.hour.toString() + ':' + selectedTime.minute.toString()),
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                {
                                  _selectTime(context)
                                },
                                child: const Text("SELECTIONNER L'HEURE")),
                            const SizedBox(
                              height: 50.0,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  var temps = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour,selectedTime.minute);
                                  print(temps.toString());
                                  Dio dio = Dio();
                                  final prefs = await SharedPreferences.getInstance();

                                  Response rlat = await dio.get('https://api.geoapify.com/v1/geocode/search?housenumber='+ _numstreet.text + '&street='+ _namestreet.text +'&city='+ _namecity.text +'&format=json&apiKey=d85ed141771b4ab8a3b0304bd9a79b5f');
                                  double lat = rlat.data['results'][0]['lat'];
                                  double lng = rlat.data['results'][0]['lon'];
                                  String adresse = _numstreet.text + ' ' + _namestreet.text + ' ' + _namecity.text;

                                  String? token = prefs.getString('accessToken');
                                  String bearerAuth = 'Bearer ' + token!;

                                  bool isPublic = false;

                                  if(_choice.toString() == 'EventType.public') {
                                    isPublic = true;
                                  }

                                  Response r = await dio.post( data.apievent , options:Options(
                                      headers: <String, String>{'authorization': bearerAuth}
                                  ),
                                      data: {
                                        'title' : _title.text,
                                        'description' : _desc.text,
                                        'date' : temps.toString(),
                                        'address' : adresse,
                                        'lat' : lat,
                                        'lon' : lng,
                                        'public' : isPublic,
                                      }
                                  );
                                  if (r.statusCode == 200) {
                                    Event e = Event(r.data['event']['id'], _title.text, _desc.text, adresse, lat, lng,temps.toString(), isPublic ? "1" : "0");
                                    Provider.of<EventCollection>(context, listen:false).add(e);
                                    Navigator.pushNamed(context, '/events');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.lightGreen,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                                child: const Text("CREER L'EVENEMENT")
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            )
        )
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      confirmText: "CONFIRMER",
      cancelText: "ANNULER",
      helpText: "MIS EN PLACE DE L'HEURE",

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;

      });
    }
  }

}
