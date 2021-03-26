import 'package:flutter/material.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/pages/EventDetailPage.dart';

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
  _EventMasterState(e) {
    this.event = e;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      //width: 100.0,
      child: Row(
        children: [
          Text(this.event.title),
          Text(this.event.date),
          ElevatedButton(
              onPressed: () {
                print(this.event.id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventDetailPage(this.event)));
              },
              child: Text("Détail"))
        ],
      ),
    );
  }
}
