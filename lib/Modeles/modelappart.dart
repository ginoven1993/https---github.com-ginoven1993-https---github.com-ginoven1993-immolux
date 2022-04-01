import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:immolux_imobilier/Modeles/modelimmeuble.dart';

class ModelAppart {
  final String id,
      description,
      latitude,
      longitude,
      typeappart,
      typeservice,
      categ,
      nbrecham,
      nom_proprio,
      num_proprio,
      locA,
      pri;

  List<dynamic> image;

  ModelAppart({
    this.id,
    this.description,
    this.latitude,
    this.longitude,
    this.typeservice,
    this.categ,
    this.typeappart,
    this.nbrecham,
    this.nom_proprio,
    this.num_proprio,
    this.pri,
    this.locA,
    this.image,
  });
}

List<ModelImmeuble> totalappart = [];

 totalAppart() async {
    await FirebaseFirestore.instance
        .collection('Immeuble')
        .where('categorie', isEqualTo: 'Appartement')
        .get()
        .then((snapshot) {
          if(snapshot.docs.length>0){
            for(var doc in snapshot.docs){
              totalappart.add(ModelImmeuble(id: doc.get('id')));
            }
          }
        });
    }
