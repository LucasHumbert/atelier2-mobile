import 'package:atelier/model/event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:atelier/data/dart_var.dart' as data;

class EventCollection extends ChangeNotifier {

  late List<Event> events = [];

  late Dio dio;
  late Response response;



  BaseOptions options = BaseOptions(
    baseUrl: data.apievent,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  void create(Event event) async {


    notifyListeners();
  }

  void update(Event event) async {

    notifyListeners();
  }

  Future<List<Event>> getAllTask() async {
    await fetchTasks();
    return events;
  }

  Future<void> fetchTasks() async {
    events = [];
    var dio = Dio(options);
    try {
      Response response = await dio.get('/');



      if(response.statusCode == 200) {
        for(var records in response.data['events']){
          var event = Event.fromJson(records);
          events.add(event);
        }
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
  }

  void delete(Event event) async {

    notifyListeners();
  }
}