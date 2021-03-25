import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Member.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text("Accueil"),
          Visibility(
              visible: Global.user.id == -1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/connect");
                },
                child: Text("Se connecter"),
              )),
          Visibility(
              visible: Global.user.id == -1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
                child: Text("S'inscrire"),
              )),
          Visibility(
              visible: Global.user.id != -1,
              child: ElevatedButton(
                onPressed: () {
                  Global.user = Member.empty();
                  Navigator.pushNamed(context, "/");
                },
                child: Text("Se deconnecter"),
              ))
        ]),
      ),
      body: Center(
        child: Text("Homepage"),
      ),
    );
  }
}
