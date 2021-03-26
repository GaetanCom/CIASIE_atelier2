import 'package:reunion_mobile/data/global.dart';

class Event {
  int id;
  String title;
  String description;
  String url;
  String date;
  int id_address;
  int id_creator;
  double lat;
  double long;
  Event(i, t, d, u, da, a, c, la, lo) {
    this.id = i;
    this.title = t;
    this.description = d;
    this.url = u;
    this.date = da;
    this.id_address = a;
    this.id_creator = c;
    this.lat = la;
    this.long = lo;
  }
}
