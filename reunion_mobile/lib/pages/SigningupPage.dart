import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/widgets/ConnectionWidget.dart';
import 'package:reunion_mobile/widgets/SigningupWidget.dart';

class SigningupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Se connecter"),
      ),
      body: Center(
        child: SigningupWidget(),
      ),
    );
  }
}
