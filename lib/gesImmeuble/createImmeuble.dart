import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

class CreateImmeuble extends StatefulWidget {
  final firebase = FirebaseFirestore.instance;

  @override
  _CreateImmeubleState createState() => _CreateImmeubleState();
}

class _CreateImmeubleState extends State<CreateImmeuble> {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  final Random _random = Random.secure();

  String CreateCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }

  List<String> selected = [];

  String immeubleId = '';
  String immeubleImageLink = '';
  List<File> fileImageArray = [];

  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  File _image;
  final picker = ImagePicker();

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        listFiles.insert(listFiles.length - 1, File(pickedFile.path));
        /* _image = File(pickedFile.path); */
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('photo-library'),
                      onTap: () async {
                        Navigator.pop(context);
                        getImageGallery();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      getImageCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      children: List.generate(listFiles.length, (index) {
        File asset = listFiles[index];
        return asset == null
            ? Stack(
                children: [
                  Container(width: 100, height: 100, color: Colors.grey),
                  InkWell(
                      onTap: () {
                        setState(() {
                          getImageGallery();
                        });
                      },
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 45,
                        ),
                      )),
                ],
              )
            : Stack(
                children: [
                  Image.file(
                    asset,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        listFiles.remove(listFiles[index]);
                      });
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 13,
                          child: Icon(
                            Icons.close,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
      }),
    );
  }

  List<File> listFiles = <File>[null];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String typeservice = 'Achat';
  var items2 = ['Achat', 'Location', 'Baille'];

  String typeImeuble = 'Etage';
  var items8 = ['Etage', 'Rez de chaussé', 'Bureau'];

  final TextEditingController idI = TextEditingController();
  final TextEditingController descI = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController long = TextEditingController();
  final TextEditingController nomPI = TextEditingController();
  final TextEditingController numPI = TextEditingController();
  final TextEditingController priI = TextEditingController();
  final TextEditingController locI = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildGridView(),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descI,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Description".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: lat,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Latitude".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: long,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Longitude".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Type Immeuble'.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "Poppins"),
                      ),
                      DropdownButton(
                        value: typeImeuble,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items8.map((String items8) {
                          return DropdownMenuItem(
                              value: items8, child: Text(items8));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            typeImeuble = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Type de Service'.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "Poppins"),
                      ),
                      DropdownButton(
                        value: typeservice,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items2.map((String items2) {
                          return DropdownMenuItem(
                              value: items2, child: Text(items2));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            typeservice = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: nomPI,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Nom du propietaire".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: numPI,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Numéro du propriétaire".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: priI,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Prix Immeuble".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: locI,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Localisation Immeuble".toString(),
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
                              minimumSize: Size(256, 55),
                              backgroundColor: Colors.blue[800]),
                          onPressed: () async {
                            List<String> ImageLinkList = <String>[];
                            for (int i = 0; i < listFiles.length - 1; i++) {
                              /* String fileName = basename(listFiles[i].path); */
                              immeubleId = CreateCryptoRandomString();
                              Reference firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child('Uploads/Immeuble/$immeubleId.jpg');
                              UploadTask uploadTask =
                                  firebaseStorageRef.putFile(listFiles[i]);
                              TaskSnapshot taskSnapshot =
                                  await uploadTask.whenComplete(() => {});

                              immeubleImageLink =
                                  await taskSnapshot.ref.getDownloadURL();
                              taskSnapshot.ref.getDownloadURL().then(
                                    (value) {},
                                  );
                              ImageLinkList.add(immeubleImageLink);
                            }

                            final documents = FirebaseFirestore.instance
                                .collection('Immeuble')
                                .doc();

                            await documents.set({
                              'id': documents.id,
                              "description": descI.text.toString(),
                              "type": typeImeuble,
                              "type_service": typeservice,
                              "nom_proprio": nomPI.text.toString(),
                              "num_proprio": numPI.text,
                              "prix": priI.text,
                              "latitude": lat.text,
                              "longitude": long.text,
                              "localisation": locI.text,
                              "image": ImageLinkList,
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Créer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Poppins"),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
