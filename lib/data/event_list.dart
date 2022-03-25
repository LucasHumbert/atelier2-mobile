import 'package:atelier/model/event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


class EventCollection extends ChangeNotifier {

  late final List<Event> events = [];

  late Dio dio;
  late Response response;



  BaseOptions options = BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  void create(Event event) async {


    notifyListeners();
  }

  void update(Event event) async {

    notifyListeners();
  }

  void getAllTask() async {
    return;
  }

  Future<void> fetchTasks() async {

  }

  void delete(Event event) async {

    notifyListeners();
  }
}