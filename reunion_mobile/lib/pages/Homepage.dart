import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/data/global.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text("Page d'accueil"),
          Visibility(
              visible: Global.user.id == -1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/connect");
                },
                child: Text("Se connecter"),
              ))
        ]),
      ),
      body: Center(
        child: Text("Homepage"),
      ),
    );
  }
}
