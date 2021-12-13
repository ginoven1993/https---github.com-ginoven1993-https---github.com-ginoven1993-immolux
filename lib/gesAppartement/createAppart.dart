import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAppart extends StatefulWidget {
  final firebase = FirebaseFirestore.instance;

  @override
  _CreateAppartState createState() => _CreateAppartState();
}

class _CreateAppartState extends State<CreateAppart> {
  String gainchaleng = 'Meublé';
  var items1 = ['Meublé', 'Non Meublé'];

  final TextEditingController idA = TextEditingController();
  final TextEditingController descA = TextEditingController();
  final TextEditingController typA = TextEditingController();
  final TextEditingController pieceA = TextEditingController();
  final TextEditingController numC = TextEditingController();
  final TextEditingController numP = TextEditingController();
  final TextEditingController priA = TextEditingController();
  final TextEditingController locT = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Type Appartement'),
                  DropdownButton(
                    value: gainchaleng,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: items1.map((String items1) {
                      return DropdownMenuItem(
                          value: items1, child: Text(items1));
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        gainchaleng = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Nombre de pièces",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Numéro Client",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Numéro du propriétaire",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Prix Appartement",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Localisation Appartement",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent),
                      onPressed: () async {
                        //natu=_lotController.text.toString();
                        //creditC=int.parse(_creditController.text.toString());

                        final documents = FirebaseFirestore.instance
                            .collection('Appartement')
                            .doc();

                        await documents.set({
                          'id': documents.id,
                          "Description": descA.text,
                          "Type Appartement": typA.text,
                          "Nombre de pièces": pieceA.text,
                          "numéro client": numC.text,
                          "numéro propriétaire": numP.text,
                          "Prix Appartement": priA.text,
                          "localisation Appartement": locT.text,
                        });
                        Navigator.pop(context);
                      },
                      child: Text("Create"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
