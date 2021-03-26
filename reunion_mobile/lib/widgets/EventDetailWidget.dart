import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:reunion_mobile/models/Event.dart';

class EventDetailWidget extends StatelessWidget {
  Event event;
  double zoom;
  EventDetailWidget(e) {
    this.event = e;
    this.zoom = 13.0;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(this.event.description),
        Row(
          children: [
            Text("Date: "),
            Text(this.event.date),
          ],
        ),
        Container(
          height: 400,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(this.event.lat, this.event.long),
              zoom: this.zoom,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: this.zoom * 3,
                    height: this.zoom * 3,
                    point: LatLng(this.event.lat, this.event.long),
                    builder: (ctx) => Container(
                      child: FlutterLogo(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
