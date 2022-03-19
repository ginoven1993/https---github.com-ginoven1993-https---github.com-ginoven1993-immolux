import 'package:flutter/material.dart';

class ModelImmeuble {
  final String id,
      description,
      latitude,
      longitude,
      type,
      shortdesc,
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
    this.shortdesc,
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
