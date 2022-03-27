import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:atelier/data/dart_var.dart' as data;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static String routeName = '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  late String accessToken;

  @override
  void dispose() {
    passwordController.dispose();
    mailController.dispose();
    super.dispose();
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
            child: Container(
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
                      TextFormField(
                        controller: mailController,
                      ),
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
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            Dio dio = Dio();
                            String username = mailController.text;
                            String password = passwordController.text;
                            String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
                            Response r = await dio.get(data.apiauth, options:Options(
                             headers: <String, String>{'authorization': basicAuth}
                            ));
                            if(r.statusCode == 200) {
                              SharedPreferences.setMockInitialValues({});
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setString('accessToken', r.data['accessToken']);
                            Navigator.pushNamed(context, '/event');
                            }
                          },
                          child: const Text('SE CONNECTER')),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                launch(
                                    'https://www.youtube.com/watch?v=dQw4w9WgXcQ')
                              },
                          child: const Text('CREER UN COMPTE')),
                    ],
                  ))
                ],
              ),
            )),
      ),
    ));
  }
}
