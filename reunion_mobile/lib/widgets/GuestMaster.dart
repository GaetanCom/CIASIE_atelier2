import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/models/Guest.dart';

class GuestMaster extends StatelessWidget {
  Guest guest;
  Color couleur = Colors.black;
  String message;
  GuestMaster(g) {
    this.guest = g;
    switch (this.guest.accept) {
      case "agreed":
        this.couleur = Colors.green[300];
        this.message = "y participe";
        break;
      case "refused":
        this.couleur = Colors.red[300];
        this.message = "n'y participe pas";
        break;
      case "waiting":
        this.couleur = Colors.blue[300];
        this.message = "n'a pas encore répondu";
        break;
    }
    print("firstname:" + g.firstname);
    print("lastname:" + g.lastname);
    print("message:" + this.message);
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      this.guest.firstname + " " + this.guest.lastname + " " + this.message,
      style: TextStyle(color: this.couleur),
    );
  }
}
