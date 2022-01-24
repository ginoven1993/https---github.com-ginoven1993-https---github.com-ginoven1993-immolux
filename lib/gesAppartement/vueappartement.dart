import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:immolux_imobilier/Maps/get_location_apart.dart';
import 'package:immolux_imobilier/Modeles/modelappart.dart';

import 'package:shimmer/shimmer.dart';

class ViewAppart extends StatefulWidget {
  final ModelAppart apart;
  ViewAppart({@required this.apart});

  final firebase = FirebaseFirestore.instance;

  @override
  _ViewAppartState createState() => _ViewAppartState();
}

class _ViewAppartState extends State<ViewAppart> {
  String priA, loc, nom, num, nbrC, cat, descript, typS, typAp, lat, long, idE;
  int etoile = 4;

  List<dynamic> imageList = [];

  void initState() {
    imageList = widget.apart.image;
    priA = widget.apart.pri;
    nom = widget.apart.nom_proprio;
    num = widget.apart.num_proprio;
    loc = widget.apart.locA;
    nbrC = widget.apart.nbrecham;
    cat = widget.apart.categ;
    descript = widget.apart.description;
    typS = widget.apart.typeservice;
    typAp = widget.apart.typeappart;
    lat = widget.apart.latitude;
    long = widget.apart.longitude;
    idE = widget.apart.id;
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
            height: MediaQuery.of(context).size.width / 3,
            child: Image(image: NetworkImage(imageList[i]), fit: BoxFit.cover),
          );
        },
      ),
    );
    return Scaffold(
      body: ListView(children: <Widget>[
        image_slide,
        SizedBox(height: 3),
        Positioned(
          top: 320,
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 30),
            width: MediaQuery.of(context).size.width,
            height: 800,
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
                    Text(
                      "Statut:  " + typS,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text("Prix: " + priA,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold)),
                        Text(' Fcfa',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(5, (index) {
                        return Icon(Icons.star,
                            color: index < etoile
                                ? Colors.yellowAccent
                                : Colors.white);
                      }),
                    ),
                    SizedBox(width: 10),
                    Text(
                      " 4,0",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text("Categories:  " + cat,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Nombres de chambres",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      fontFamily: "Poppins",
                    )),
                SizedBox(height: 5),
                Wrap(
                  children: List.generate(1, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          '' + nbrC,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                Text('Description',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('' + descript,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontFamily: "Poppins",
                    )),
                SizedBox(height: 8),
                Text('Informations Propriétaires : ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nom :  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    Text('' + nom,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Numero :  ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
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
                SizedBox(height: 15),
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
                      '' + typAp,
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
                              builder: (context) => GetLocationApart(
                                idapart: idE,
                              ),
                            ),
                          );
                        },
                        child: Text('Localisation Apparts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                              fontSize: 17,
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
