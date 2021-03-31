import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/models/Guest.dart';
import 'package:reunion_mobile/models/Member.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:reunion_mobile/models/Message.dart';

class Global {
  static Member user = Member.empty();
  static String host = "192.168.0.10:19080";
  static List<Event> events = [];

  static Future makeList() async {
    Global.events = [];
    var client = new http.Client();

    var uri = Uri.parse("http://" +
        Global.host +
        "/events/byMember/" +
        Global.user.id.toString());
    client.get(uri).then((response) {
      var json = jsonDecode(response.body);
      for (var i = 0; i < json.length; i++) {
        var event = json[i];
        var uri2 = Uri.parse(
            "http://" + Global.host + "/events/" + event["url"] + "/members");
        client.get(uri2).then((response2) {
          print(response2.body);
          // var uri3= Uri.parse("http://" + Global.host + "/events/" + event["url"] + "/members");
          List<Guest> guests = [];
          var json2 = jsonDecode(response2.body);
          //print(json2["tabMembers"]);

          for (var i = 0; i < json2["tabMembers"].length; i++) {
            var guest = json2["tabMembers"][i];
            print(guest);
            guests.add(new Guest(guest["idGuests"], guest["accept"],
                guest["firstname"], guest["lastname"]));
          }
          Global.events.add(
            new Event(
                event["id"],
                event["title"],
                event["description"],
                event["url"],
                event["date"],
                event["creator"],
                event["lat"],
                event["long"],
                event["state"],
                guests, <Message>[]),
          );
        });
      }
      //this.events.addAll(json["events"]);
    });
  }
}
