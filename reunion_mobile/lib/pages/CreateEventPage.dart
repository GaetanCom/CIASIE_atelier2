import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/widgets/CreateEventWidget.dart';

class CreateEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("creer un evenement"),
        centerTitle: true,
      ),
      body: CreateEventWidget(),
    );
  }
}
