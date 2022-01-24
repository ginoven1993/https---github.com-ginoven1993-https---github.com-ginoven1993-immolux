import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:immolux_imobilier/Maps/get_location.dart';
import 'package:immolux_imobilier/Maps/get_location_mag.dart';
import 'package:immolux_imobilier/Modeles/modelemagasin.dart';
import 'package:shimmer/shimmer.dart';

class ViewProducts extends StatefulWidget {
  final ModelMagasin mag;

  ViewProducts({@required this.mag});
  final firebase = FirebaseFirestore.instance;

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  String priM, loc, nom, num, typSM, typeM, descripte, lat, long, idE;
  int etoile = 4;
  List<dynamic> imageList = [];

  void initState() {
    imageList = widget.mag.image;
    priM = widget.mag.pri;
    nom = widget.mag.nom_proprio;
    num = widget.mag.num_proprio;
    loc = widget.mag.locT;
    typSM = widget.mag.typeservice;
    typeM = widget.mag.typemagasin;
    descripte = widget.mag.description;
    lat = widget.mag.latitude;
    long = widget.mag.longitude;
    idE = widget.mag.id;
  }

  @override
  Widget build(BuildContext context) {
    Widget image_slide = Container(
      child: CarouselSlider.builder(
        itemCount: imageList.length,
        options: CarouselOptions(
          height: 290.0,
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
        SizedBox(height: 10),
        Positioned(
          top: 300,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 30),
            width: MediaQuery.of(context).size.width,
            height: 550,
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
                    Text("Statut: " + typSM,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    Row(
                      children: [
                        Text("Prix: " + priM,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(' Fcfa', style: TextStyle(color: Colors.white)),
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
                SizedBox(height: 20),
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
                SizedBox(height: 25),
                Text('Description',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('' + descripte,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: "Poppins",
                    )),
                SizedBox(height: 20),
                Text('Informations Propriétaires',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
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
                      'Numero  : ',
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
                      '' + typeM,
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
                              builder: (context) => GetLocationMag(
                                idmag: idE,
                              ),
                            ),
                          );
                        },
                        child: Text('Localisation Magasin',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                              fontSize: 16,
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
