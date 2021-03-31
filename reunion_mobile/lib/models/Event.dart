import 'package:reunion_mobile/data/global.dart';
import 'package:reunion_mobile/models/Guest.dart';
import 'package:reunion_mobile/models/Message.dart';

class Event {
  int id;
  String title;
  String description;
  String url;
  String date;
  String creator;
  double lat;
  double long;
  int state;
  List<Guest> guests;
  List<Message> messages;
  Event(i, t, d, u, da, c, la, lo, st, gu, me) {
    this.id = i;
    this.title = t;
    this.description = d;
    this.url = u;
    this.date = da;
    this.creator = c;
    this.lat = la;
    this.long = lo;
    this.state = st;
    this.guests = gu;
    this.messages = me;
  }
}
