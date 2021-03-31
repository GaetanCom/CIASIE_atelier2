import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:place_picker/place_picker.dart';
import "package:http/http.dart" as http;
import 'package:reunion_mobile/data/global.dart';

class CreateEventWidget extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var addressController = TextEditingController();
  var addressNumController = TextEditingController();
  var addressZipController = TextEditingController();
  var addressCountryController = TextEditingController();
  DateTime date = DateTime.now();
  void createEvent(BuildContext c) {
    print("title:" +
        titleController.text +
        "|description:" +
        descriptionController.text +
        "|date:" +
        date.toString() +
        "|address:" +
        addressController.text);
    if (addressNumController.text == "" ||
        addressController.text == "" ||
        addressZipController.text == "" ||
        addressCountryController.text == "") {
      ScaffoldMessenger.of(c).showSnackBar(
          SnackBar(content: Text("Veuillez entrer une addresse complete")));
      return;
    }
    var client = new http.Client();

    var uri = Uri.parse("http://" + Global.host + "/events/address");
    print(uri.host);
    print(uri.port);
    client
        .post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "number": addressNumController.text,
              "street": addressController.text,
              "country": addressCountryController.text,
              'zipcode': addressZipController.text
            }))
        .then((response) {
      print(response.body);
      var json = jsonDecode(response.body);
      var uri2 = Uri.parse("http://" + Global.host + "/events");
      client
          .post(uri2,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                "title": titleController.text,
                "description": descriptionController.text,
                "date": date.toString(),
                'idCreator': Global.user.id.toString(),
                "idAddress": json["idAddress"].toString()
              }))
          .then((response2) {
        print(response2.body);
        var data = jsonDecode(response2.body)["url"];
        Clipboard.setData(ClipboardData(text: data.toString()));
        ScaffoldMessenger.of(c).showSnackBar(SnackBar(
            content: Text("L'url a été copiée dans votre presse-papier")));
        Navigator.pop(c);
      });
    });
  }

  void showPlacePicker(BuildContext c) async {
    LocationResult result = await Navigator.of(c).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "",
              displayLocation: LatLng(48, 6),
            )));

    // Handle the result in your way
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: <Widget>[
          Text(
            "Titre",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: titleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un titre';
              }
              return null;
            },
          ),
          Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: descriptionController,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer une description';
              }
              return null;
            },
          ),
          Text(
            "Date:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          InputDatePickerFormField(
              firstDate: DateTime(2021),
              lastDate: DateTime(2030),
              onDateSaved: (d) {
                this.date = d;
              }),
          Text(
            "Lieu:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          TextField(
            controller: addressNumController,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(labelText: "Numéro addresse"),
          ),
          TextField(
            controller: addressController,
            keyboardType: TextInputType.streetAddress,
            decoration: new InputDecoration(labelText: "Rue"),
          ),
          TextField(
            controller: addressZipController,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(labelText: "Code postal"),
          ),
          TextField(
            controller: addressCountryController,
            keyboardType: TextInputType.streetAddress,
            decoration: new InputDecoration(labelText: "Pays"),
          ),

          ElevatedButton(
            onPressed: () {
              createEvent(context);
            },
            child: Text('Se connecter'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
