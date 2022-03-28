import 'package:atelier/model/event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:atelier/data/dart_var.dart' as data;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OneEvent extends StatefulWidget {

  static String routeName = '/oneevent';

  OneEvent({Key? key}) : super(key: key);

  @override
  State<OneEvent> createState() => _OneEvent();
}

class _OneEvent extends State<OneEvent> {

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Event;

    return FlutterMap(
      options: MapOptions(
        center: LatLng(args.lat, args.lon),
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
              point: LatLng(args.lat, args.lon),
              builder: (ctx) =>
                  Container(
                    child: const Icon(Icons.location_on),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
