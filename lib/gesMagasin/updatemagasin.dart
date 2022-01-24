import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immolux_imobilier/Modeles/modelemagasin.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class UpdateMagasin extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final ModelMagasin mag;

  UpdateMagasin({@required this.mag});
  @override
  _UpdateMagasinState createState() => _UpdateMagasinState();
}

class _UpdateMagasinState extends State<UpdateMagasin> {
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

  String magasinId = '';
  String magasinImageLink = '';
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

  String typemagasin = 'Entrepot';
  var items10 = ['Entrepot', 'Bureau'];
  String typeservice = 'Achat';
  var items20 = ['Achat', 'Location', 'Baille'];

  final TextEditingController descM = TextEditingController();
  final TextEditingController typM = TextEditingController();
  final TextEditingController nomP = TextEditingController();
  final TextEditingController numPM = TextEditingController();
  final TextEditingController priM = TextEditingController();
  final TextEditingController locM = TextEditingController();
  final TextEditingController typS = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController long = TextEditingController();
  void initState() {
    descM.text = widget.mag.description;
    typM.text = widget.mag.typemagasin;
    nomP.text = widget.mag.nom_proprio;
    numPM.text = widget.mag.num_proprio;
    priM.text = widget.mag.pri;
    locM.text = widget.mag.locT;
    typS.text = widget.mag.typeservice;
    lat.text = widget.mag.latitude;
    long.text = widget.mag.longitude;
  }

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
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisCount: 4,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    children: List.generate(widget.mag.image.length, (index) {
                      return widget.mag.image[index] == null
                          ? Stack(
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey),
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
                                CachedNetworkImage(
                                  imageUrl: widget.mag.image[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.mag.image
                                          .remove(widget.mag.image[index]);
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
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                    }),
                  ),
                  buildGridView(),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descM,
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
                      Text('Type de Magasin'.toString()),
                      DropdownButton(
                        value: typemagasin,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items10.map((String items10) {
                          return DropdownMenuItem(
                              value: items10, child: Text(items10));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            typemagasin = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Type de Service'.toString()),
                      DropdownButton(
                        value: typeservice,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items20.map((String items20) {
                          return DropdownMenuItem(
                              value: items20, child: Text(items20));
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
                    controller: nomP,
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
                    controller: numPM,
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
                    controller: priM,
                    decoration: InputDecoration(
                      labelText: "Prix du magasin".toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: locM,
                    decoration: InputDecoration(
                      labelText: "Localisation du magasin".toString(),
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
                              backgroundColor: Colors.lightBlueAccent),
                          onPressed: () async {
                            List<String> ImageLinkList = <String>[];
                            for (int i = 0; i < listFiles.length - 1; i++) {
                              /* String fileName = basename(listFiles[i].path); */
                              magasinId = CreateCryptoRandomString();
                              Reference firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child('Uploads/Magasin/$magasinId.jpg');
                              UploadTask uploadTask =
                                  firebaseStorageRef.putFile(listFiles[i]);

                              TaskSnapshot taskSnapshot =
                                  await uploadTask.whenComplete(() => {});

                              magasinImageLink =
                                  await taskSnapshot.ref.getDownloadURL();
                              taskSnapshot.ref.getDownloadURL().then(
                                    (value) {},
                                  );
                              widget.mag.image.add(magasinImageLink);
                            }

                            final documents = FirebaseFirestore.instance
                                .collection('Magasin')
                                .doc(widget.mag.id);

                            await documents.update({
                              'id': documents.id,
                              "description": descM.text.toString(),
                              "type": typemagasin,
                              "type_service": typeservice,
                              "nom_proprio": nomP.text.toString(),
                              "num_proprio": numPM.text,
                              "prix": priM.text,
                              "latitude": lat.text,
                              "longitude": long.text,
                              "localisation": locM.text,
                              "image": widget.mag.image,
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Modifier",
                            style: TextStyle(
                              fontSize: 20,
                            ),
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
