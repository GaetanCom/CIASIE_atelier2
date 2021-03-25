import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Member.dart';

class SigningupWidget extends StatefulWidget {
  @override
  _SigningupWidgetState createState() => _SigningupWidgetState();
}

class _SigningupWidgetState extends State<SigningupWidget> {
  final formkey = GlobalKey<FormState>();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var pseudoController = TextEditingController();
  var pwdController = TextEditingController();
  var verifPwdController = TextEditingController();
  var emailController = TextEditingController();
  void isRegistered(c) async {
    var firstname = firstnameController.text;
    var lastname = lastnameController.text;
    var login = pseudoController.text;
    var pwd = pwdController.text;
    var verifPwd = verifPwdController.text;
    var email = emailController.text;

    print("Pseudo: " + pseudoController.text);
    print("Password: " + pwdController.text);

    var client = new http.Client();

    var uri = Uri.parse(
        "http://docketu.iutnc.univ-lorraine.fr:13003/users/connection/signup");
    print(uri.host);
    print(uri.port);
    var json = '{"firstname":"${firstname}",' +
        '"lastname":"${lastname}",' +
        '"pseudo":"${login}",' +
        '"password":"${pwd}",' +
        '"id_status":"2",' +
        '"mail":"${email}","id_status":2}';
    print(json);
    if (pwd == verifPwd) {
      var response = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.body);
        var jsonUser = jsonDecode(response.body);
        Global.user = new Member(
            jsonUser["id"],
            jsonUser["firstname"],
            jsonUser["lastName"],
            jsonUser["mail"],
            jsonUser["pseudo"],
            jsonUser["password"]);
        Navigator.pushNamed(c, "/");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Un probleme est apparu, veuillez reesayer plus tard')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Les mots de passe sont différents')));
    }

    /*client.post(uri, body: json).then((response) {
      print(response.body);
    });*/
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
          Text("Prénom"),
          TextFormField(
            controller: firstnameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un pseudo';
              }
              return null;
            },
          ),
          Text("Nom"),
          TextFormField(
            controller: lastnameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un pseudo';
              }
              return null;
            },
          ),
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
          Text("Retaper le mot de passe"),
          TextFormField(
            controller: verifPwdController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez confirmer le mot de passe';
              }
              return null;
            },
          ),
          Text("Email"),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un email';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              seConnecter(context);
            },
            child: Text("S'inscrire"),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
