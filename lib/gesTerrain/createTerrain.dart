import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class CreateTerrain extends StatefulWidget {
  final firebase = FirebaseFirestore.instance;

  @override
  _CreateTerrainState createState() => _CreateTerrainState();
}

class _CreateTerrainState extends State<CreateTerrain> {
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

  String terrainId = '';
  String terrainImageLink = '';
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

  String typeterrain = 'Urbain';
  var items1 = ['Urbain', 'Agricole'];
  String typeservice = 'Achat';
  var items2 = ['Achat', 'Location', 'Baille'];

  final TextEditingController descT = TextEditingController();
  final TextEditingController typT = TextEditingController();
  final TextEditingController nomP = TextEditingController();
  final TextEditingController numPT = TextEditingController();
  final TextEditingController priT = TextEditingController();
  final TextEditingController locT = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController long = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 42),
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
                    controller: descT,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        
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
                    controller: lat,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                       
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
                    controller: long,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                       
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
                      Text('Type de Terrain'.toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),),
                      DropdownButton(
                        value: typeterrain,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items1.map((String items1) {
                          return DropdownMenuItem(
                              value: items1, child: Text(items1));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            typeterrain = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Type de Service'.toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Poppins"),),
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
                    controller: nomP,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                       
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
                    controller: numPT,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                       
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
                    controller: priT,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                       
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Prix du terrain".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: locT,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      
                        fontFamily: "Poppins"),
                    decoration: InputDecoration(
                      labelText: "Localisation du terrain".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: TextButton.styleFrom(
                              minimumSize: Size(276, 55),
                              backgroundColor: Colors.blue[800]),
                          onPressed: () async {
                            List<String> ImageLinkList = <String>[];
                            for (int i = 0; i < listFiles.length - 1; i++) {
                              /* String fileName = basename(listFiles[i].path); */
                              terrainId = CreateCryptoRandomString();
                              Reference firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child('Uploads/Terrain/$terrainId.jpg');
                              UploadTask uploadTask =
                                  firebaseStorageRef.putFile(listFiles[i]);
                              TaskSnapshot taskSnapshot =
                                  await uploadTask.whenComplete(() => {});

                              terrainImageLink =
                                  await taskSnapshot.ref.getDownloadURL();
                              taskSnapshot.ref.getDownloadURL().then(
                                    (value) {},
                                  );
                              ImageLinkList.add(terrainImageLink);
                            }

                            final documents = FirebaseFirestore.instance
                                .collection('Terrain')
                                .doc();

                            await documents.set({
                              'id': documents.id,
                              "description": descT.text.toString(),
                              "type": typeterrain,
                              "type_service": typeservice,
                              "nom_proprio": nomP.text.toString(),
                              "num_proprio": numPT.text,
                              "prix": priT.text,
                              "localisation": locT.text,
                              "latitude": lat.text,
                              "longitude": long.text,
                              "image": ImageLinkList,
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Créer",
                            style: TextStyle(
                        fontWeight: FontWeight.w600,
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
