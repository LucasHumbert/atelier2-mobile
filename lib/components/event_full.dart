import 'package:atelier/model/event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:atelier/data/dart_var.dart' as data;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventFull extends StatefulWidget {

  Event event;

  EventFull(this.event , {Key? key}) : super(key: key);

  @override
  State<EventFull> createState() => _EventFull();
}

class _EventFull extends State<EventFull> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('test');
      },
      child: Container(
          child: Column(
            children:[
              Text(widget.event.title),
              Text(widget.event.description),
              Text(widget.event.address),
              FlutterMap(
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                        point: LatLng(51.5, -0.09),
                        builder: (ctx) =>
                            Container(
                              child: FlutterLogo(),
                            ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}
