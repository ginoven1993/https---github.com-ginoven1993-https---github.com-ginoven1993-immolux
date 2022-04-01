import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:immolux_imobilier/Maps/get_location.dart';
import 'package:immolux_imobilier/Maps/get_location_imeub.dart';
import 'package:immolux_imobilier/Modeles/modelimmeuble.dart';

import 'package:shimmer/shimmer.dart';

class ViewImmeuble extends StatefulWidget {
  final ModelImmeuble imeub;

  ViewImmeuble({@required this.imeub});
  final firebase = FirebaseFirestore.instance;

  @override
  _ViewImmeubleState createState() => _ViewImmeubleState();
}

class _ViewImmeubleState extends State<ViewImmeuble> {
  String priI, loc, nom, cate, comme, comdem, doc, num, typSI, typeI, descrip, lat, long, idE;
  List<dynamic> imageList = [];

  void initState() {
    imageList = widget.imeub.image;
    priI = widget.imeub.pri;
    nom = widget.imeub.nom_proprio;
    num = widget.imeub.num_proprio;
    loc = widget.imeub.locI;
    typSI = widget.imeub.typeservice;
    typeI = widget.imeub.type;
    descrip = widget.imeub.description;
    lat = widget.imeub.latitude;
    long = widget.imeub.longitude;
    idE = widget.imeub.id;
    cate = widget.imeub.categorie;
    comme= widget.imeub.com;
    comdem = widget.imeub.comdemarch;
    doc = widget.imeub.document;
  }

  @override
  Widget build(BuildContext context) {
    Widget image_slide = Container(
      child: CarouselSlider.builder(
        itemCount: imageList.length,
        options: CarouselOptions(
          height: 300.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
        ),
        itemBuilder: (BuildContext context, i, _) {
          return Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.width / 2,
            child: Image(image: NetworkImage(imageList[i]), fit: BoxFit.cover),
          );
        },
      ),
    );
    return Scaffold(
      body: ListView(children: <Widget>[
        image_slide,
        SizedBox(height: 1),
        Positioned(
          top: 250,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 20),
            width: MediaQuery.of(context).size.width,
            height: 700,
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categorie: "+ cate,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    Row(
                      children: [
                        Text("Prix: " + priI,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(' Fcfa',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.black),
                    Text(
                      "" + loc,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
               Row(
                  children: [
                   Text(
                      "Commisison: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          ""+ comme,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),Text(
                          "%",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                   Row(
                  children: [
                   Text(
                      "Commisison demarcheur: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          " "+ comdem,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                   Row(
                  children: [
                   Text(
                      "Document : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      " "+ doc,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text('Description',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('' + descrip,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: "Poppins",
                    )),
                SizedBox(height: 25),
                Text('Informations Propriétaires ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nom : ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Poppins",
                        )),
                    Text('' + nom,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Numero : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Text(
                      '' + num,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Type : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Text(
                      '' + typeI,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 75),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetLocationImeub(
                                idimeub: idE,
                              ),
                            ),
                          );
                        },
                        child: Text('Localisation '+cate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                              fontSize: 14,
                              fontFamily: "Poppins",
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
