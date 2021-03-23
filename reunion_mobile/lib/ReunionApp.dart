import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/pages/ConnectionPage.dart';
import 'package:reunion_mobile/pages/Homepage.dart';

class ReunionApp extends StatefulWidget {
  @override
  _ReunionAppState createState() => _ReunionAppState();
}

class _ReunionAppState extends State<ReunionApp> {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      routes: {
        "/connect": (context) => ConnectionPage(),
        "/": (context) => Homepage()
      },
      title: 'Reunionou',
      theme: ThemeData(
        fontFamily: "Knewave",
        primarySwatch: Colors.teal,
      ),
    );
  }
}
