import 'package:reunion_mobile/data/global.dart';

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
  Event(i, t, d, u, da, c, la, lo, st) {
    this.id = i;
    this.title = t;
    this.description = d;
    this.url = u;
    this.date = da;
    this.creator = c;
    this.lat = la;
    this.long = lo;
    this.state = st;
  }
}