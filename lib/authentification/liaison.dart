import 'package:flutter/material.dart';
import 'package:immolux_imobilier/authentification/login.dart';
import '../gesTerrain/accueil.dart';

class Liaisonhome extends StatefulWidget {
  @override
  _LiaisonhomeState createState() => _LiaisonhomeState();
}

class _LiaisonhomeState extends State<Liaisonhome> {
  bool afficheLogin = true;

  void basculation() {
    setState(() => afficheLogin = !afficheLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (afficheLogin) {
      return Home();
    } else {
      return Login(basculation: basculation);
    }
  }
}
