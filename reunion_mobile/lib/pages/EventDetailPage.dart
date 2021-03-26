import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/widgets/EventDetailWidget.dart';

class EventDetailPage extends StatelessWidget {
  Event event;
  EventDetailPage(e) {
    this.event = e;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.event.title),
      ),
      body: EventDetailWidget(this.event),
    );
  }
}
