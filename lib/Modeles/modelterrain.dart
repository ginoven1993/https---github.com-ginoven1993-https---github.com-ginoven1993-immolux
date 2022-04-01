import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:immolux_imobilier/Modeles/modelimmeuble.dart';

class ModelTerrain {
  final String id,
      description,
      latitude,
      longitude,
      typeterrain,
      typeservice,
      nom_proprio,
      locT,
      pri,
      numPT;

  List<dynamic> image;

  ModelTerrain({
    this.id,
    this.description,
    this.latitude,
      this.longitude,
    this.typeterrain,
    this.typeservice,
    this.nom_proprio,
    this.pri,
    this.locT,
    this.numPT,
    this.image,
  });
}

List<ModelImmeuble> totalterrain = [];

 totalTerrain() async {
    await FirebaseFirestore.instance
        .collection('Immeuble')
        .where('categorie', isEqualTo: 'Terrain')
        .get().then((snapshot){
          if(snapshot.docs.length>0){
            for(var doc in snapshot.docs){
              totalterrain.add(ModelImmeuble(id: doc.get('id')));
            }
          }
        });
    
    }
