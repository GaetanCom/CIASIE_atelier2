import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Event.dart';
import "package:http/http.dart" as http;

class EventDetailWidget extends StatefulWidget {
  Event event;
  double zoom;
  EventDetailWidget(e) {
    this.event = e;
    this.zoom = 13.0;
  }

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {
  void accept() {
    var client = new http.Client();

    var uri = Uri.parse("http://" +
        Global.host +
        "/events/" +
        this.widget.event.url +
        "/member/" +
        Global.user.id.toString());
    client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"choice": "1"}));
    print(uri.host);
    print(uri.port);
    setState(() {});
  }

  void decline() {
    var client = new http.Client();

    var uri = Uri.parse("http://" +
        Global.host +
        "/events/" +
        this.widget.event.url +
        "/member/" +
        Global.user.id.toString());
    client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"choice": "2"}));
    print(uri.host);
    print(uri.port);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(this.widget.event.description),
        Row(
          children: [
            Text("Date: "),
            Text(this.widget.event.date),
          ],
        ),
        Row(
          children: [
            Visibility(
                visible: this.widget.event.state == 3,
                child: ElevatedButton(
                  onPressed: () {
                    accept();
                    print("Accepter");
                  },
                  child: Text("✓"),
                )),
            Visibility(
                visible: this.widget.event.state == 3,
                child: ElevatedButton(
                  onPressed: () {
                    decline();
                    print("Refuser");
                  },
                  child: Text("X"),
                ))
          ],
        ),
        Container(
          height: 400,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(this.widget.event.lat, this.widget.event.long),
              zoom: this.widget.zoom,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: this.widget.zoom * 3,
                    height: this.widget.zoom * 3,
                    point:
                        LatLng(this.widget.event.lat, this.widget.event.long),
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
