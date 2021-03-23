import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectionWidget extends StatefulWidget {
  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  final formkey = GlobalKey<FormState>();

  Future<bool> isRegistered() async {
    final response =
        await http.get(Uri.https('http://localhost:19080', 'users'));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(jsonDecode(response.body))));
    /*if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }*/
  }

  void seConnecter() {
    if (formkey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
      isRegistered();
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un pseudo';
              }
              return null;
            },
          ),
          Text("Mot de passe"),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: seConnecter,
            child: Text('Se connecter'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
