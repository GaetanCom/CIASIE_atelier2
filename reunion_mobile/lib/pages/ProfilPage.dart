import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/data/global.dart';
import "package:http/http.dart" as http;
import 'package:reunion_mobile/models/Member.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final formkey = GlobalKey<FormState>();

  var pseudoController = TextEditingController();

  var pwdController = TextEditingController();

  var firstnameController = TextEditingController();

  var lastnameController = TextEditingController();

  var mailController = TextEditingController();
  int _selectedIndex = 1;
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

  void save(BuildContext c) {
    var client = http.Client();
    var uri1 = Uri.parse("http://" + Global.host + "/users/update/firstname");
    var uri2 = Uri.parse("http://" + Global.host + "/users/update/lastname");
    var uri3 = Uri.parse("http://" + Global.host + "/users/update/mail");
    var uri4 = Uri.parse("http://" + Global.host + "/users/update/pseudo");
    var uri5 = Uri.parse("http://" + Global.host + "/users/update/password");
    if (firstnameController.text != "")
      client.post(uri1,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "firstname": firstnameController.text,
            "id": Global.user.id.toString()
          }));
    if (lastnameController.text != "")
      client.post(uri2,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "lastname": lastnameController.text,
            "id": Global.user.id.toString()
          }));
    if (pseudoController.text != "")
      client.post(uri4,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "pseudo": pseudoController.text,
            "id": Global.user.id.toString()
          }));
    if (mailController.text != "")
      client.post(uri3,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "mail": mailController.text,
            "id": Global.user.id.toString()
          }));

    if (pwdController.text != "")
      client.post(uri5,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "newpassword": pwdController.text,
            "oldpassword": Global.user.password,
            "id": Global.user.id.toString()
          }));

    var uri6 = Uri.parse("http://" +
        Global.host +
        "/users/connection/checkRegistered?login=" +
        pseudoController.text +
        "&pwd=" +
        pwdController.text);

    client.get(uri6).then((response) {
      print(response.body);
      var json = jsonDecode(response.body);
      print(json["idMembers"]);
      if (json["idMembers"] != null) {
        Global.user = new Member(json["idMembers"], json["firstname"],
            json["lastName"], json["mail"], json["pseudo"], json["password"]);
        ScaffoldMessenger.of(c).showSnackBar(
            SnackBar(content: Text("Les informations on été mises à jour")));
        Navigator.pop(c);
      } else {
        ScaffoldMessenger.of(c)
            .showSnackBar(SnackBar(content: Text(json["message"])));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion du profil"),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            Text("Pseudo"),
            TextField(
              controller: pseudoController,
              decoration: new InputDecoration(labelText: Global.user.pseudo),
            ),
            Text("Mot de passe"),
            TextField(
              controller: pwdController,
              decoration:
                  new InputDecoration(labelText: "Changer le mot de passe"),
              obscureText: true,
            ),
            Text("Prenom"),
            TextField(
              controller: firstnameController,
              decoration: new InputDecoration(labelText: Global.user.firstName),
            ),
            Text("Nom"),
            TextField(
              controller: lastnameController,
              decoration: new InputDecoration(labelText: Global.user.lastName),
            ),
            Text("Mail"),
            TextField(
              controller: mailController,
              decoration: new InputDecoration(labelText: Global.user.mail),
              keyboardType: TextInputType.emailAddress,
            ),
            ElevatedButton(
              onPressed: () {
                save(context);
              },
              child: Text('Sauvegarder les modifications'),
            ),
            // Add TextFormFields and ElevatedButton here.
          ],
        ),
      ),
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
