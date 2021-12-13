import 'package:flutter/material.dart';
import 'package:immolux_imobilier/authentification/login.dart';
import 'package:immolux_imobilier/authentification/registration.dart';

class Liaison extends StatefulWidget {
  @override
  _LiaisonState createState() => _LiaisonState();
}

class _LiaisonState extends State<Liaison> {
  bool afficheLogin = true;

  void basculation() {
    setState(() => afficheLogin = !afficheLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (afficheLogin) {
      return Login(basculation: basculation);
    } else {
      return Registration(basculation: basculation);
    }
  }
}
