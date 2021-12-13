import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:immolux_imobilier/authentification/registration.dart';
import 'chargement.dart';

class Login extends StatefulWidget {
  final Function basculation;
  Login({this.basculation});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  bool chargement = false;

  final _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return chargement
        ? Chargement()
        : Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Flexible(
                      child: Center(
                        child: Text(
                          'IMMOLUX',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[500].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            hintText: 'Email',
                          ),
                          validator: (val) => val.isEmpty ? 'Email' : null,
                          onChanged: (val) => email = val,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[500].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            hintText: 'Mot de Passe',
                          ),
                          obscureText: true,
                          validator: (val) =>
                              val.length < 6 ? 'Mot de passe incorrect' : null,
                          onChanged: (val) => password = val,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.lightBlue),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_keyform.currentState.validate()) {
                            setState(() => chargement = true);
                            UserCredential result =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (result == null) {
                              //afficher error
                            }
                          }
                        },
                        child: Text(
                          'Se Connecter',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registration(),
                            ),
                          );
                        },
                        child: Text(
                          'Nouveau Compte',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
