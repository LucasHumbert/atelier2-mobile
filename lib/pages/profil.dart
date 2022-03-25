import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:atelier/data/dart_var.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  static String routeName = '/profil';

  @override
  State<Profil> createState() => _Profil();
}

class _Profil extends State<Profil> {

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold());
  }
}
