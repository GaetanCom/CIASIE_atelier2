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
  int _selectedIndex = 0;
  var urlController = TextEditingController();
  _HomepageState() {
    // Global.makeList();
  }
  void initState() {
    super.initState();
    () async {
      await Global.makeList();
      setState(() {});
    }();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, "/home");
            break;
          case 1:
            Navigator.pushReplacementNamed(context, "/profil");
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Accueil"),
          Visibility(
              visible: Global.user.id != -1,
              child: ElevatedButton(
                onPressed: () {
                  Global.user = Member.empty();
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: Icon(Icons.logout),
              )),
          Visibility(
              visible: Global.user.id != -1,
              child: ElevatedButton(
                onPressed: () {
                  Global.makeList();

                  setState(() {});
                },
                child: Icon(Icons.replay_outlined),
              )),
        ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bienvenue " + Global.user.firstName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                    // print(response.body);

                    setState(() {});
                  });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Url invalide")));
                }
              },
              child: Text("Participer")),
          EventList(Global.events),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateEventPage()));
          },
          child: Text("+")),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
