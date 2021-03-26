import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/models/Member.dart';

import 'package:reunion_mobile/widgets/EventList.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    Global.makeList();
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Text("Accueil"),
            Visibility(
                visible: Global.user.id != -1,
                child: ElevatedButton(
                  onPressed: () {
                    Global.user = Member.empty();
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  child: Text("Se deconnecter"),
                )),
            Visibility(
                visible: Global.user.id != -1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      print(Global.events[0].title);
                    });
                  },
                  child: Text("Recharger"),
                )),
          ]),
        ),
        body: Visibility(
          visible: Global.user.id != -1,
          child: Container(
            height: 600.0,
            //width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Bienvenue " + Global.user.firstName),
                EventList(Global.events)
              ],
            ),
          ),
        ));
  }
}
