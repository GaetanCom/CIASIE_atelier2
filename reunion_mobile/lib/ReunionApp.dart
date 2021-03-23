import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reunion_mobile/pages/ConnectionPage.dart';

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
        "/": (context) => ConnectionPage(),
      },
      title: 'Reunionou',
      theme: ThemeData(
        fontFamily: "Knewave",
        primarySwatch: Colors.teal,
      ),
    );
  }
}
