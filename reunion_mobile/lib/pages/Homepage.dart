import 'dart:convert';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/models/Member.dart';
import 'package:reunion_mobile/pages/CreateEventPage.dart';

import 'package:reunion_mobile/widgets/EventList.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Event> events = [];
  var urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(Global.user.id);
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
                  Global.makeList();

                  setState(() {});
                  //Navigator.pushReplacementNamed(context, "/home");
                },
                child: Text("Recharger"),
              )),
          Visibility(
              visible: Global.user.id != -1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/profil");
                },
                child: Text("Profil"),
              ))
        ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Bienvenue " + Global.user.firstName),
          EventList(Global.events),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateEventPage()));
              },
              child: Text("+")),
          Text("Participer a un event:"),
          TextField(
            controller: urlController,
          ),
          ElevatedButton(
              onPressed: () {
                var client = http.Client();
                if (urlController.text != "") {
                  var uri = Uri.parse("http://" +
                      Global.host +
                      "/events/" +
                      urlController.text +
                      "/member");
                  print("url");
                  client
                      .post(uri,
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            "memberId": Global.user.id.toString(),
                          }))
                      .then((response) {
                    print(response.body);

                    setState(() {});
                  });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Url invalide")));
                }
              },
              child: Text("Participer"))
        ],
      ),
    );
  }
}
