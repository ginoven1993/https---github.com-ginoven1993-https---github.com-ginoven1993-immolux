import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:immolux_imobilier/Menu.dart';
import 'package:immolux_imobilier/users_auth/delayanimation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Delay(),
      ),
    );
  }
}
