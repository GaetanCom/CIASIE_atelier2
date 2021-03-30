import 'package:flutter/cupertino.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/widgets/EventMaster.dart';

class EventList extends StatefulWidget {
  List<Event> events;
  EventList(l) {
    this.events = l;
  }
  @override
  _EventListState createState() => _EventListState(this.events);
}

class _EventListState extends State<EventList> {
  List<Event> events;
  _EventListState(l) {
    this.events = l;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      key: UniqueKey(),
      // width: 100.0,
      child: ListView.builder(
        itemCount: this.events.length,
        itemBuilder: (BuildContext ctx, int index) {
          return EventMaster(this.events[index]);
        },
      ),
    );
  }
}
