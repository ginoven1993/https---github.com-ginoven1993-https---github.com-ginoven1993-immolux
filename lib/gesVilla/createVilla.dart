import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateVilla extends StatefulWidget {
  final firebase = FirebaseFirestore.instance;

  @override
  _CreateVillaState createState() => _CreateVillaState();
}

class _CreateVillaState extends State<CreateVilla> {
  String gainchaleng = 'Meublé';
  var items1 = ['Meublé', 'Non Meublé'];

  final TextEditingController idV = TextEditingController();
  final TextEditingController descV = TextEditingController();
  final TextEditingController typV = TextEditingController();
  final TextEditingController numC = TextEditingController();
  final TextEditingController numP = TextEditingController();
  final TextEditingController locV = TextEditingController();
  final TextEditingController priV = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/Profile Image.png"),
                    ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: () {},
                          child: IconButton(
                              icon: Icon(Icons.photo_camera), onPressed: () {}),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
                  Text('Type de Villa'),
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
                  labelText: "Prix de la Villa",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Localisation Villa",
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
                            .collection('Villa')
                            .doc();

                        await documents.set({
                          'id': documents.id,
                          "description": descV.text,
                          "type de Villa": typV.text,
                          "numéro client": numC.text,
                          "numéro propriétaire": numP.text,
                          "localisation Villa": locV.text,
                          "Prix de la Villa": priV.text,
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
