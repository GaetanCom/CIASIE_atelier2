import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/models/Member.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class Global {
  static Member user = Member.empty();
  static String host = "192.168.0.10:19080";
  static List<Event> events = [];

  static void makeList() {
    print(Global.user.firstName);
    Global.events = [];
    var client = new http.Client();

    var uri = Uri.parse("http://" +
        Global.host +
        "/events/byMember/" +
        Global.user.id.toString());
    print(Global.user.id);
    client.get(uri).then((response) {
      print(response.body);
      var json = jsonDecode(response.body);
      //print(json["events"][0]["id"]);
      //print(json[0]);
      for (var i = 0; i < json.length; i++) {
        var event = json[i];
        print(event["id"]);
        Global.events.add(
          new Event(
              event["id"],
              event["title"],
              event["description"],
              event["url"],
              event["date"],
              event["creator"],
              event["lat"],
              event["long"]),
        );
      }
      //this.events.addAll(json["events"]);
    });
  }
}
