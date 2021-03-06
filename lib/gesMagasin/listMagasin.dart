import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:immolux_imobilier/Modeles/modelemagasin.dart';
import 'package:immolux_imobilier/gesMagasin/createmagasin.dart';
import 'package:immolux_imobilier/gesMagasin/updatemagasin.dart';
import 'package:immolux_imobilier/gesMagasin/vueproduit.dart';
import 'package:shimmer/shimmer.dart';

class HomeMagasin extends StatefulWidget {
  @override
  _HomeMagasinState createState() => _HomeMagasinState();
}

class _HomeMagasinState extends State<HomeMagasin> {
  String state = '0';
  showAlert(BuildContext context, title, content, Widget deleteButton) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel".toString()),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [cancelButton, deleteButton],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
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
                                          ? Colors.blue[800]
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
                                          "Tous",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: state == '1'
                                                  ? Colors.white
                                                  : Colors.blue[800],
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
                                          ? Colors.blue[800]
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
                                                  : Colors.blue[800],
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
                                          ? Colors.blue[800]
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
                                                  : Colors.blue[800],
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
                                        ? Colors.blue[800]
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
                                              : Colors.blue[800],
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
                                        ? Colors.blue[800]
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
                                              : Colors.blue[800],
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
                                        ? Colors.blue[800]
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
                                      "Activer",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: state == '8'
                                              ? Colors.white
                                              : Colors.blue[800],
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
                                        ? Colors.blue[800]
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
                                              : Colors.blue[800],
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
                        .collection('Magasin')
                        .snapshots()
                    : state == '2'
                        ? FirebaseFirestore.instance
                            .collection('Immeuble')
                            .where('type_service', isEqualTo: 'Achat')
                            .snapshots()
                        : state == '3'
                            ? FirebaseFirestore.instance
                                .collection('Immeuble')
                                .where('type_service', isEqualTo: 'Location')
                                .snapshots()
                            : state == '5'
                                ? FirebaseFirestore.instance
                                    .collection('Immeuble')
                                    .where('type_service', isEqualTo: 'Baille')
                                    .snapshots()
                                : state == '6'
                                    ? FirebaseFirestore.instance
                                        .collection('Magasin')
                                        .snapshots()
                                    : state == '7'
                                        ? FirebaseFirestore.instance
                                            .collection('Magasin')
                                            .snapshots()
                                        : state == '8'
                                            ? FirebaseFirestore.instance
                                                .collection('Magasin')
                                                .snapshots()
                                            : FirebaseFirestore.instance
                                                .collection('Magasin')
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewProducts(
                                            mag: ModelMagasin(
                                              id: doc['id'],
                                              description: doc['description'],
                                              typeservice: doc['type_service'],
                                              typemagasin: doc['type'],
                                              nom_proprio: doc['nom_proprio'],
                                              num_proprio: doc['num_proprio'],
                                              pri: doc['prix'],
                                              locT: doc['localisation'],
                                              image: doc['image'],
                                            ),
                                          )),
                                );
                              },
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
                                            child: CachedNetworkImage(
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
                                                doc['nom_proprio'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  doc['num_proprio'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  doc['prix'],
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
                                          doc['type_service'],
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
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewProducts(
                                                  mag: ModelMagasin(
                                                    id: doc['id'],
                                                    description:
                                                        doc['description'],
                                                    typeservice:
                                                        doc['type_service'],
                                                    typemagasin: doc['type'],
                                                    nom_proprio:
                                                        doc['nom_proprio'],
                                                    num_proprio:
                                                        doc['num_proprio'],
                                                    pri: doc['prix'],
                                                    locT: doc['localisation'],
                                                    image: doc['image'],
                                                  ),
                                                )),
                                      );
                                    },
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
                                    onTap: () {
                                      /* await FirebaseFirestore.instance
                                          .collection('Terrain')
                                          .doc(doc['id'])
                                          .update(
                                            doc['id'],
                                          );*/
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateMagasin(
                                            mag: ModelMagasin(
                                              id: doc['id'],
                                              description: doc['description'],
                                              typeservice: doc['type_service'],
                                              typemagasin: doc['type'],
                                              nom_proprio: doc['nom_proprio'],
                                              num_proprio: doc['num_proprio'],
                                              pri: doc['prix'],
                                              locT: doc['localisation'],
                                              image: doc['image'],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconSlideAction(
                                    caption: 'supprimer',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () => {
                                      showAlert(
                                          context,
                                          'Avertissement',
                                          'Cet action de suppression est irr??versible. Etes vous s??r de vouloir supprimer ce Produit?',
                                          FlatButton(
                                            child: Text("Supprimer"),
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('Immeuble')
                                                  .doc(doc['id'])
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                          ))
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
                return CreateMagasin();
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
