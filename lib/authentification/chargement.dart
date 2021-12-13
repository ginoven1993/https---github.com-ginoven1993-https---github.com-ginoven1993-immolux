import 'package:flutter/material.dart';

class Chargement extends StatefulWidget {
  @override
  _ChargementState createState() => _ChargementState();
}

class _ChargementState extends State<Chargement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 100.0),
        child: Column(
          children: <Widget>[
            Text("Chargement...."),
          ],
        ),
      ),
    );
  }
}
