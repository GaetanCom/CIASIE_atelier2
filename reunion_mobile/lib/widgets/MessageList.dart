import 'package:flutter/cupertino.dart';
import 'package:reunion_mobile/models/Event.dart';
import 'package:reunion_mobile/models/Guest.dart';
import 'package:reunion_mobile/widgets/EventMaster.dart';
import 'package:reunion_mobile/widgets/GuestMaster.dart';
import 'package:reunion_mobile/widgets/MessageMaster.dart';

class MessageList extends StatefulWidget {
  List<Message> messages;
  MessageList(l) {
    this.messages = l;
  }
  @override
  _GuestListState createState() => _GuestListState(this.messages);
}

class _MessageGuestListState extends State<MessageList> {
  List<Message> messages;
  _MessageListState(l) {
    this.messages = l;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      key: UniqueKey(),
      // width: 100.0,
      child: ListView.builder(
        itemCount: this.messages.length,
        itemBuilder: (BuildContext ctx, int index) {
          return MessageMaster(this.messages[index]);
        },
      ),
    );
  }
}
