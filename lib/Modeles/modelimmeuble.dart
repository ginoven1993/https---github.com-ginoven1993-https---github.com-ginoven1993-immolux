import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelImmeuble {
  final String id,
      
      description,
      latitude,
      longitude,
      type,
      typeservice,
      nom_proprio,
      num_proprio,
      /* ajout */
      categorie,
      comdemarch,
      com,
      document,
      nbr_chambre,
      nbr_douche,
      id_proprio,
     
/* end ajour */
      pri,
      locI;
bool active, disponible;
  List<dynamic> image;

  ModelImmeuble({
    this.id,
    this.description,
    this.latitude,
    this.longitude,
    this.type,
    this.typeservice,
    this.nom_proprio,
    this.num_proprio,
    this.pri,
    this.locI,
    this.image,
   this. categorie,
     this. comdemarch,
     this. com,
      this.document,
     this. nbr_chambre,
     this. nbr_douche,
      this.id_proprio,
    this.  active,
    this.disponible,
  });
}

List<ModelImmeuble> totalimmeuble = [];

  totalImmeuble() async {
    await FirebaseFirestore.instance
        .collection('Immeuble')
        .where('categorie', isEqualTo: 'Immeuble')
         .get().then((snapshot){
        if(snapshot.docs.length>0){
          for(var doc in snapshot.docs){
             totalimmeuble.add(ModelImmeuble(id: doc.get('id')));
          }
        }
      });
    }
