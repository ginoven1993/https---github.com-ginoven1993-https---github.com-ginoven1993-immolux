import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immolux_imobilier/Menu.dart';
import 'package:immolux_imobilier/users_auth/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

  bool showProgress = false;
  bool visible = false;
  bool isAdmin;
  String val;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  final TextEditingController password = new TextEditingController();
  final TextEditingController confirmpass = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  String type = 'Admin';
  var itemstype = ['Admin', 'Client'];

  bool _isObscure = true;
  bool _isObscure2 = true;
  File file;
  bool shouldPop = true;

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    String _idUser() {
      if (user != null) {
        return user.uid;
      } else {
        return "pas d'utilisateur courant";
      }
    }

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 80),
                        Text(
                          "Créer votre compte",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          controller: nom,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Nom',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Entrer votre nom' : null,
                          onChanged: (val) =>
                              nom = val as TextEditingController,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: prenom,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Prenom',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Entrer votre prenom' : null,
                          onChanged: (val) =>
                              prenom = val as TextEditingController,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: numero,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Numero de Telephone',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Entrer votre numero' : null,
                          onChanged: (val) =>
                              numero = val as TextEditingController,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(15),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.length == 0) {
                              return "Email ne peut etre vide";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Svp Entrer un email valide");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: password,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Mot de Passe',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value.isEmpty) {
                              return "Champ ne doit pas etre vide";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Mot de Passe non valide..Min 6 charactères");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpass,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Confirmez Mot de Passe',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (confirmpass.text != password.text) {
                              return "Passe Incorrect";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Text('Role',
                                style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.w600,
                                   fontSize: 18,
                                  fontFamily: "Poppins"),
                                ),
                             DropdownButton(
                                value: type,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: itemstype.map((String itemstype) {
                                      return DropdownMenuItem(
                                          value: itemstype, child: Text(itemstype));
                                }).toList(),
                                onChanged: (String newValue) {
                                      setState(() {
                                      type = newValue;
                                      });
                                },
                             ),
                           ],
                         ),
                          SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                CircularProgressIndicator();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                                signUp(
                                  email.text,
                                  password.text,
                                );
                                  nom.clear();
                                  prenom.clear();
                                  numero.clear();
                                  email.clear();
                                  password.clear();
                              },
                              child: Text(
                                "S'INSCRIRE",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                  shouldPop = !shouldPop;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Se Connecter",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  signUp(String email, String password) async {
    if (_formkey.currentState.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .whenComplete(() => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                  )
                });
               User user = userCredential.user;
                final documents = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid);
                                await documents.set({
                                  'id': documents.id,
                                  'nom': nom.text.toString(),
                                  'prenom': prenom.text.toString(),
                                  'numero': numero.text,
                                  'Email': email,
                                  'Mot_de_Passe': password,
                                  });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'mot de Passe-faible') {
          print('Le mot de Passe donné est faible.');
        } else if (e.code == 'Email deja utilisé') {
          print('Un compte existe deja pour ce mail.');
        }
      } catch (e) {
        print(e);
      }
    }

    CircularProgressIndicator();
  }
}
