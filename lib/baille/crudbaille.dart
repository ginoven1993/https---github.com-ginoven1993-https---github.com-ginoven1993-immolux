import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudBaille extends StatefulWidget {
  @override
  _CrudBailleState createState() => _CrudBailleState();
}

class _CrudBailleState extends State<CrudBaille> {
  bool isChecked = false;
  TextEditingController ter = TextEditingController();
  TextEditingController loc = TextEditingController();
  TextEditingController apart = TextEditingController();
  TextEditingController locapart = TextEditingController();
  TextEditingController mais = TextEditingController();
  TextEditingController locamais = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  create() async {
    try {
      await firebase.collection("baille").doc(ter.text).set({
        "terrain": ter.text,
        "Localisation": loc.text,
        "Appartement": apart.text,
        "localisationA": locapart.text,
        "maison&villa": mais.text,
        "localisationM": locamais.text,
      });
    } catch (e) {
      print(e);
    }
  }

  read() async {
    try {} catch (e) {
      print(e);
    }
  }

  update() async {
    try {
      await firebase.collection("baille").doc(ter.text).update({
        "terrain": ter.text,
        "Localisation": loc.text,
        "Appartement": apart.text,
        "localisation": locapart.text,
      });
    } catch (e) {
      print(e);
    }
  }

  delete() async {
    try {
      await firebase.collection("baille").doc(ter.text).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: ter,
                decoration: InputDecoration(
                  labelText: "Terrain",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: loc,
                decoration: InputDecoration(
                  labelText: "Localisation Terrain",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text("Rurale"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text("Agricole"),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      create();
                      ter.clear();
                      loc.clear();
                    },
                    child: Text("Create"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      read();
                      ter.clear();
                      loc.clear();
                    },
                    child: Text("Read"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      update();
                      ter.clear();
                      loc.clear();
                    },
                    child: Text("Update"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      delete();
                      ter.clear();
                      loc.clear();
                    },
                    child: Text("Delete"),
                  ),
                ],
              ),
              TextField(
                controller: apart,
                decoration: InputDecoration(
                  labelText: "Appartements",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: locapart,
                decoration: InputDecoration(
                  labelText: "Localisation Appartement",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text("meublé"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text("non-meublé"),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      create();
                      apart.clear();
                      locapart.clear();
                    },
                    child: Text("Create"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      read();
                      apart.clear();
                      locapart.clear();
                    },
                    child: Text("Read"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      update();
                      apart.clear();
                      locapart.clear();
                    },
                    child: Text("Update"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      delete();
                      apart.clear();
                      locapart.clear();
                    },
                    child: Text("Delete"),
                  ),
                ],
              ),
              TextField(
                controller: apart,
                decoration: InputDecoration(
                  labelText: "Maison&Villa",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: locapart,
                decoration: InputDecoration(
                  labelText: "Localisation Maison&Villa",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text("cours Unique"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text("cours commune"),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      create();
                      mais.clear();
                      locamais.clear();
                    },
                    child: Text("Create"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      read();
                      mais.clear();
                      locamais.clear();
                    },
                    child: Text("Read"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      update();
                      mais.clear();
                      locamais.clear();
                    },
                    child: Text("Update"),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {
                      delete();
                      mais.clear();
                      locamais.clear();
                    },
                    child: Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
