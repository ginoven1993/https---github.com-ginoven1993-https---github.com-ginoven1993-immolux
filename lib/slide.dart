import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:immolux_imobilier/Modeles/modeleslide.dart';

class Slide extends StatefulWidget {
  final ModelSlide slid;

   Slide({@required this.slid});
   final firebase = FirebaseFirestore.instance;

   @override
  _SlideState createState() => _SlideState();

}

class _SlideState extends State<Slide> {
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


List<dynamic> slideList = [];
List<File> fileImageArray = [];
File _image;
List<File> listFiles = <File>[null];
List<String> selected = [];

String slideId = '';
String slideImageLink = '';
final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
       padding: EdgeInsets.symmetric(horizontal: 12),
       child: ListView(
         children: [
           Form(
           child: Column(
             children: [
               buildGridView(),
               SizedBox(height: 19),
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
                              slideId = CreateCryptoRandomString();
                              Reference firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child('Uploads/Slide/$slideId.jpg');
                              UploadTask uploadTask =
                                  firebaseStorageRef.putFile(listFiles[i]);
                              TaskSnapshot taskSnapshot =
                                  await uploadTask.whenComplete(() => {});

                              slideImageLink =
                                  await taskSnapshot.ref.getDownloadURL();
                              taskSnapshot.ref.getDownloadURL().then(
                                    (value) {},
                                  );
                              ImageLinkList.add(slideImageLink);
                            } 

                            final documents = FirebaseFirestore.instance
                                .collection('Slide')
                                .doc();

                            await documents.set({
                              'id': documents.id,
                              "image": ImageLinkList,
                            });
                            Navigator.pop(context);
                          },

                       child: Text("Envoyer",
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