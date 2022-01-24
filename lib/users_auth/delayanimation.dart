import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:immolux_imobilier/Menu.dart';
import 'package:immolux_imobilier/users_auth/login.dart';

class Delay extends StatefulWidget {
  @override
  _DelayState createState() => _DelayState();
}

class _DelayState extends State<Delay> {
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      if (status) {
        _navigationWelcome();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 6000), () {});
    return true;
  }

  void _navigationWelcome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue[800],
            alignment: Alignment.center,
            child: SizedBox(
              width: 300,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 45.0,
                  fontFamily: 'Canterbury',
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText(
                      'immolux',
                      textAlign: TextAlign.center,
                      duration: Duration(
                        milliseconds: 7000,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
