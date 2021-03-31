import 'package:flutter/material.dart';
import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/pages/EventDetailPage.dart';
import "package:http/http.dart" as http;

class EventMaster extends StatefulWidget {
  Event event;
  EventMaster(e) {
    this.event = e;
  }
  @override
  _EventMasterState createState() => _EventMasterState(this.event);
}

class _EventMasterState extends State<EventMaster> {
  Event event;
  Color color;

  _EventMasterState(e) {
    this.event = e;
    print("test");
    print(this.event.state);
    if (this.event.state == 1) {
      this.color = Colors.green[300];
    }
    if (this.event.state == 2) {
      this.color = Colors.red[300];
    }
    if (this.event.state == 3) {
      this.color = Colors.lightBlue[100];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.color,
      height: 100.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                this.event.title,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(this.event.date),
                  Text("Par: " + this.event.creator),
                ],
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                print(this.event.id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventDetailPage(this.event)));
              },
              child: Text("Détail")),
        ],
      ),
    );
  }
}
