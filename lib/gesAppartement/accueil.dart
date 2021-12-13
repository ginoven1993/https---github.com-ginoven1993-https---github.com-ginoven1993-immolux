import 'dart:math';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:immolux_imobilier/gesAppartement/createAppart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:immolux_imobilier/achats/crud.dart';
import 'package:immolux_imobilier/baille/crudbaille.dart';
import 'package:immolux_imobilier/locations/crudlocation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String state = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 45,
        title: const Text('Immolux_Immobilier'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 59.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 0.0, bottom: 15)),
                  Expanded(
                      child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = '1';
                            });
                            print(state);
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                    height: 29.5,
                                    decoration: BoxDecoration(
                                      color: state == '1'
                                          ? Colors.lightBlueAccent
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.5,
                                          spreadRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          "Tout",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: state == '1'
                                                  ? Colors.white
                                                  : Colors.lightBlueAccent,
                                              fontFamily: "Sans"),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = '2';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                    height: 29.5,
                                    decoration: BoxDecoration(
                                      color: state == '2'
                                          ? Colors.lightBlueAccent
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.5,
                                          spreadRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          "Achats",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: state == '2'
                                                  ? Colors.white
                                                  : Colors.lightBlueAccent,
                                              fontFamily: "Sans"),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = '3';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                    height: 29.5,
                                    decoration: BoxDecoration(
                                      color: state == '3'
                                          ? Colors.lightBlueAccent
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.5,
                                          spreadRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          "Locations",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: state == '3'
                                                  ? Colors.white
                                                  : Colors.lightBlueAccent,
                                              fontFamily: "Sans"),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = '5';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                  height: 29.5,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    color: state == '5'
                                        ? Colors.lightBlueAccent
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.5,
                                        spreadRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Baille",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: state == '5'
                                              ? Colors.white
                                              : Colors.lightBlueAccent,
                                          fontFamily: "Sans"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = '6';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                  height: 29.5,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    color: state == '6'
                                        ? Colors.lightBlueAccent
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.5,
                                        spreadRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Desactiver",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: state == '6'
                                              ? Colors.white
                                              : Colors.lightBlueAccent,
                                          fontFamily: "Sans"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = '8';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                  height: 29.5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: state == '8'
                                        ? Colors.lightBlueAccent
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.5,
                                        spreadRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Active",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: state == '8'
                                              ? Colors.white
                                              : Colors.lightBlueAccent,
                                          fontFamily: "Sans"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = '7';
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, left: 6.0, right: 10),
                                child: Container(
                                  height: 29.5,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    color: state == '7'
                                        ? Colors.lightBlueAccent
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.5,
                                        spreadRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "En attente",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: state == '7'
                                              ? Colors.white
                                              : Colors.lightBlueAccent,
                                          fontFamily: "Sans"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ))
                ],
              ),
            ),
            StreamBuilder(
                stream: state == '1'
                    ? FirebaseFirestore.instance
                        .collection('Appartement')
                        .snapshots()
                    : state == '2'
                        ? FirebaseFirestore.instance
                            .collection('Appartement')
                            .snapshots()
                        : state == '3'
                            ? FirebaseFirestore.instance
                                .collection('Appartement')
                                .snapshots()
                            : state == '5'
                                ? FirebaseFirestore.instance
                                    .collection('Appartement')
                                    .snapshots()
                                : state == '6'
                                    ? FirebaseFirestore.instance
                                        .collection('Appartement')
                                        .snapshots()
                                    : state == '7'
                                        ? FirebaseFirestore.instance
                                            .collection('Appartement')
                                            .snapshots()
                                        : state == '8'
                                            ? FirebaseFirestore.instance
                                                .collection('Appartement')
                                                .snapshots()
                                            : FirebaseFirestore.instance
                                                .collection('Appartement')
                                                .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data.docs.length == 0) {
                    return Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Center(
                          child: Text('resultat-vide'),
                        ));
                  }

                  return ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((doc) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                        child: Container(
                            color: Colors.grey.shade200.withOpacity(0.5),
                            child: InkWell(
                              onTap: () async {},
                              child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10,
                                      bottom: 10 * 0.75,
                                      top: 10 * 0.75),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            color: Colors.grey[300],
                                            height: 70,
                                            width: 120,
                                            /*  child: CachedNetworkImage(
                                                imageUrl: doc['image'][0],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Shimmer.fromColors(
                                                            highlightColor:
                                                                Colors
                                                                    .grey[100],
                                                            enabled: true,
                                                            child: Container(
                                                                height: 70,
                                                                width: 70)),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.cover),
                                           */
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doc['Appartement'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  IconSlideAction(
                                    caption: 'voir',
                                    color: Colors.blue,
                                    icon: Icons.archive,
                                    onTap: () {},
                                  ),
                                  /* IconSlideAction(
      caption: 'Share',
      color: Colors.indigo,
      icon: Icons.share,
      onTap: () {},
    ), */
                                ],
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'modifier',
                                    color: Colors.black45,
                                    icon: Icons.edit,
                                    onTap: () async {},
                                  ),
                                  IconSlideAction(
                                    caption: 'supprimer',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () => {
                                      /* 
                                            showAlert(
                                                context,
                                                'Avertissement',
                                                'Cet action de suppression est irréversible. Etes vous sûr de vouloir supprimer ce Produit?',
                                                FlatButton(
                                                  child: Text("Supprimer"),
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Pays')
                                                        .doc(actualCountry)
                                                        .collection('Produits')
                                                        .doc(doc['id'])
                                                        .delete();
                                                    Navigator.pop(context);
                                                  },
                                                ))
                                          */
                                    },
                                  )
                                ],
                              ),
                            )),
                      );
                    }).toList(),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreateAppart();
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
