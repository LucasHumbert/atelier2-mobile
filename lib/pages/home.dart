import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: const TextSpan(
                      text: 'CONNEXION',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
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
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                      text: const TextSpan(
                          text: 'VOTRE EMAIL',
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
                  TextFormField(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  RichText(
                      text: const TextSpan(
                          text: 'MOT DE PASSE',
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
                  TextFormField(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      onPressed: () => {

                      },
                      child: const Text('SE CONNECTER')
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                        launch('http://youtube.com/')
                      },
                      child: const Text('CREER UN COMPTE')
                  ),

                ],
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
