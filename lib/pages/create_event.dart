import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  static String routeName = '/create_event';

  @override
  State<CreateEventPage> createState() => _CreateEventPage();
}

class _CreateEventPage extends State<CreateEventPage> {

  final _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        //_dateController.text =;
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 10),
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
                  Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Titre de l'évènement"
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Description"
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Adresse"
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ElevatedButton(
                              onPressed: () =>
                              {

                              },
                              child: const Text("SELECT DATE")),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                              onPressed: () =>
                              {Navigator.pushNamed(context, '/event')},
                              child: const Text("CREER L'EVENEMENT")),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ))
                ],
              ),
            )
        )
    );
  }
}
