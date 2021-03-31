import 'package:flutter/cupertino.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/models/Guest.dart';
import 'package:reunion_mobile/widgets/EventMaster.dart';
import 'package:reunion_mobile/widgets/GuestMaster.dart';

class GuestList extends StatefulWidget {
  List<Guest> guests;
  GuestList(l) {
    this.guests = l;
  }
  @override
  _GuestListState createState() => _GuestListState(this.guests);
}

class _GuestListState extends State<GuestList> {
  List<Guest> guests;
  _GuestListState(l) {
    this.guests = l;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      key: UniqueKey(),
      // width: 100.0,
      child: ListView.builder(
        itemCount: this.guests.length,
        itemBuilder: (BuildContext ctx, int index) {
          return GuestMaster(this.guests[index]);
        },
      ),
    );
  }
}
