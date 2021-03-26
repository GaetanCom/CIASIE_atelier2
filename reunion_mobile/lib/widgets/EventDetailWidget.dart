import 'package:flutter/cupertino.dart';
import 'package:reunion_mobile/models/Event.dart';

class EventDetailWidget extends StatelessWidget {
  Event event;
  EventDetailWidget(e) {
    this.event = e;
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
      ],
    );
  }
}
