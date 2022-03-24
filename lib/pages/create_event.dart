import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  static String routeName = '/create_event';

  @override
  State<CreateEventPage> createState() => _CreateEventPage();
}

class _CreateEventPage extends State<CreateEventPage> {

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();


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
                              onPressed: () {
                                var temps = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour,selectedTime.minute);
                                print(temps.toString());
                                Navigator.pushNamed(context, '/event');
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
                      ))
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
