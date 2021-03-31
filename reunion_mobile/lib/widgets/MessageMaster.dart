import 'package:flutter/cupertino.dart';
import 'package:reunion_mobile/models/Message.dart';

class MessageMaster extends StatelessWidget {
  Message message;
  MessageMaster(m) {
    this.message = m;
  }
  @override
  Widget build(BuildContext context) {
    return Row(children: [Column(children: [this.message.],)]);
  }
}
