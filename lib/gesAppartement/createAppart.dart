import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class CreateAppart extends StatefulWidget {
  final firebase = FirebaseFirestore.instance;

  @override
  _CreateAppartState createState() => _CreateAppartState();
}

class _CreateAppartState extends State<CreateAppart> {
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

  String appartId = '';
  String appartImageLink = '';
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
                            color: Colors.blue[800],
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

  String categappart = 'Maison';
  var items30 = ['Maison', 'Villa'];

  String typeservice = 'Achat';
  var items40 = ['Achat', 'Location', 'Baille'];

  String typeappart = 'Meuble';
  var items50 = ['Meuble', 'Non Meuble', 'Cours Unique', 'Cours Commune'];

  final TextEditingController descA = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController long = TextEditingController();
  final TextEditingController chambre = TextEditingController();
  final TextEditingController nomC = TextEditingController();
  final TextEditingController numP = TextEditingController();
  final TextEditingController priA = TextEditingController();
  final TextEditingController locA = TextEditingController();
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
                    controller: descA,
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
                        'Type Service'.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "Poppins"),
                      ),
                      DropdownButton(
                        value: typeservice,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items40.map((String items40) {
                          return DropdownMenuItem(
                              value: items40, child: Text(items40));
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categorie Appartement'.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "Poppins"),
                      ),
                      DropdownButton(
                        value: categappart,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items30.map((String items30) {
                          return DropdownMenuItem(
                              value: items30, child: Text(items30));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            categappart = newValue;
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
                        'Type Appartement',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "Poppins"),
                      ),
                      DropdownButton(
                        value: typeappart,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items50.map((String items50) {
                          return DropdownMenuItem(
                              value: items50, child: Text(items50));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            typeappart = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: chambre,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Nombre de chambres".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: nomC,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Nom proprietaire".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: numP,
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
                    controller: priA,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Prix Appartement".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: locA,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Localisation Appartement".toString(),
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
                              appartId = CreateCryptoRandomString();
                              Reference firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child('Uploads/Appartement/$appartId.jpg');
                              UploadTask uploadTask =
                                  firebaseStorageRef.putFile(listFiles[i]);
                              TaskSnapshot taskSnapshot =
                                  await uploadTask.whenComplete(() => {});

                              appartImageLink =
                                  await taskSnapshot.ref.getDownloadURL();
                              taskSnapshot.ref.getDownloadURL().then(
                                    (value) {},
                                  );
                              ImageLinkList.add(appartImageLink);
                            }
                            final documents = FirebaseFirestore.instance
                                .collection('Appartement')
                                .doc();

                            await documents.set({
                              'id': documents.id,
                              "description": descA.text.toString(),
                              "type_service": typeservice,
                              "Categorie_Appartement": categappart,
                              "type": typeappart,
                              "Nombre_de_chambres": chambre.text,
                              "nom_proprio": nomC.text.toString(),
                              "num_proprio": numP.text,
                              "prix": priA.text,
                              "latitude": lat.text,
                              "longitude": long.text,
                              "localisation": locA.text.toString(),
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
