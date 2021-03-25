import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Member.dart';

class ConnectionWidget extends StatefulWidget {
  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  final formkey = GlobalKey<FormState>();
  var pseudoController = TextEditingController();
  var pwdController = TextEditingController();
  void isRegistered(c) async {
    var login = pseudoController.text;
    var pwd = pwdController.text;
    print("Pseudo: " + pseudoController.text);
    print("Password: " + pwdController.text);

    var client = new http.Client();

    var uri = Uri.parse(
        "http://docketu.iutnc.univ-lorraine.fr:13003/users/connection/checkRegistered?login=" +
            login +
            "&pwd=" +
            pwd);
    print(uri.host);
    print(uri.port);

    client.get(uri).then((response) {
      print(response.body);
      var json = jsonDecode(response.body);

      if (json["id"] != null) {
        Global.user = new Member(json["id"], json["firstname"],
            json["lastName"], json["mail"], json["pseudo"], json["password"]);
        Navigator.pushNamed(c, "/");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(json["message"])));
      }

      /*if (response.body != "-1") {
      
        
        Global.user = new Member(json["id"], json["firstname"],
            json["lastName"], json["mail"], json["pseudo"], json["password"]);

        Navigator.pushNamed(c, "/");
      } else {
        print("mauvaise connexion");
        
      }*/
    });
  }

  void seConnecter(c) {
    if (formkey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // ScaffoldMessenger.of(context)
      //   .showSnackBar(SnackBar(content: Text('Veuillez patienter')));
      isRegistered(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: <Widget>[
          Text("Pseudo"),
          TextFormField(
            controller: pseudoController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un pseudo';
              }
              return null;
            },
          ),
          Text("Mot de passe"),
          TextFormField(
            controller: pwdController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              seConnecter(context);
            },
            child: Text('Se connecter'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
