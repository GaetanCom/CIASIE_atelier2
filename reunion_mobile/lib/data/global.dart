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
        "/events/createdBy/" +
        Global.user.id.toString());
    print(Global.user.id);
    client.get(uri).then((response) {
      print(response.body);
      var json = jsonDecode(response.body);
      print(json["events"][0]["id"]);

      for (var i = 0; i < json["events"].length; i++) {
        var event = json["events"][i];
        print(event.toString());
        Global.events.add(
          new Event(
              event["idEvents"],
              event["title"],
              event["description"],
              event["url"],
              event["date"],
              event["id_address"],
              Global.user.id,
              48.692054,
              6.184417),
        );
      }
      //this.events.addAll(json["events"]);
    });
  }
}
